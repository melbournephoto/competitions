class Slides
  def generate_download_path
    'tmp/' + Digest::SHA1.hexdigest(Rails.application.secrets.secret_key_base + Time.now.to_s) + '.zip'
  end

  def generate_monthly(competition, email)
    path = generate_download_path
    @slide = Slide.new
    Zip::File.open(Rails.root.join('public', path), Zip::File::CREATE) do |zipfile|
      #title slide
      zipfile.add('0000-title.jpg', @slide.generate(
                                    upper_text: ['The Melbourne Camera Club'],
                                    lower_text: [competition.title],
                                    image_path: Rails.root.join('app/assets/images/logo.png')))

      # competition section slides
      competition.sections.each do |section|
        section.competition_series.grades.each do |grade|
          slide_path = @slide.generate(
            upper_text: ['The Melbourne Camera Club'],
            lower_text: [section.title + ' - ' + grade.title],
            image_path: Rails.root.join('app/assets/images/logo.png')
          )
          zipfile.add(section.order.to_s + grade.order.to_s + '00-0000000000.jpg', slide_path)
          zipfile.add(section.order.to_s + grade.order.to_s + '00-9999999999.jpg', slide_path)
        end
      end

      #entry photos + award slides
      competition.entries.each do |entry|
        begin
          zipfile.add(entry.section.order.to_s + entry.grade.order.to_s + '00-' + sprintf("%.10d", entry.order) + '.jpg', entry.photo.path)
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
            zipfile.add(sort_section + sort_grade + '1' + entry.rating.points.to_s + '-' + sprintf("%.10d", entry.order) + '.jpg', slide_path)
          end
        rescue Errno::ENOENT
        end
      end
    end

    Download.complete(email, path).deliver
  end

  def generate_titled_slides(competition, email)
    path = generate_download_path
    @slide = Slide.new(background_color: '#000000', fill_color: 'white')
    Zip::File.open(Rails.root.join('public', path), Zip::File::CREATE) do |zipfile|
      competition.entries.each do |entry|
        slide_path = @slide.generate(
          upper_text: [],
          lower_text: [entry.user.name + ' - ' + entry.title],
          image_path: entry.photo.path
        )
        zipfile.add(entry.order.to_s + '.jpg', slide_path)
      end
    end
    Download.complete(email, path).deliver
  end
end