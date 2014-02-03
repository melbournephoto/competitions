class Judging::DownloadEntriesController < JudgingController
  def new
    dir = Dir.mktmpdir
    path = File.join(dir, 'entries.zip')
    Zip::File.open(path, Zip::File::CREATE) do |zipfile|
      current_competition.entries.each do |entry|
        zipfile.add(entry.grade.title + '/' + entry.order.to_s + '.jpg', entry.photo.path)
      end
    end

    send_file(path)
  end
end
