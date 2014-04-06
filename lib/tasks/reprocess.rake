task :reprocess => :environment do
  entries = Entry.all
  entries.each_with_index do |entry, index|
    puts "(#{index}/#{entries.count}) #{entry.title}"
    entry.photo.recreate_versions!
    entry.save!
  end
end