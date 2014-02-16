class Admin::DownloadCompetitionsController < AdminController
  def show
    #file name parts
    # section order
    # grade order
    @competition = Competition.find(params[:id])
    dir = Dir.mktmpdir
    path = File.join(dir, 'edi.zip')
    @slide = Slide.new()
    Zip::File.open(path, Zip::File::CREATE) do |zipfile|
      #title slide
      zipfile.add('000-title.jpg', @slide.generate(
          upper_text: ['The Melbourne Camera Club'],
          lower_text: [@competition.title],
          image_path: Rails.root.join('app/assets/images/logo.png')))

      # competition section slides
      @competition.sections.each do |section|
        section.competition_series.grades.each do |grade|
          slide_path = @slide.generate(
              upper_text: ['The Melbourne Camera Club'],
              lower_text: [section.title + ' - ' + grade.title],
              image_path: Rails.root.join('app/assets/images/logo.png')
          )
          zipfile.add(section.order.to_s + grade.order.to_s + '0-0grade-header.jpg', slide_path)
        end
      end

      #entry photos + award slides
      @competition.entries.each do |entry|
        zipfile.add(entry.section.order.to_s + entry.grade.order.to_s + '0-' + entry.order.to_s + '.jpg', entry.photo.path)
        if entry.rating && entry.rating.points > 1

          title = entry.rating.title
          slide_path = @slide.generate(
              upper_text: ['The Melbourne Camera Club'],
              lower_text: [
                  [entry.user.name, entry.title].join(' - '),
                  [entry.grade.title, title].join(' - ')
              ],
              image_path: entry.photo.path
          )
          sort_section = entry.section.order.to_s
          if entry.rating.points > 5
            sort_section = '9'
          end
          sort_grade = entry.grade.order.to_s
          zipfile.add(sort_section + sort_grade + '1-' + entry.order.to_s + '.jpg', slide_path)
        end
      end
    end

    send_file(path)
  end
end
