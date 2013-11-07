# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a_grade = Grade.find_or_create_by!(title: 'A Grade')
b_grade = Grade.find_or_create_by!(title: 'B Grade')

user = User.find_or_create_by!(email: 'alan@alanharper.com.au', admin: 1) do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.first_name = 'Alan'
  user.last_name = 'Harper'
end

user = User.find_or_create_by!(email: 'ludovico@melbournephoto.org.au') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.first_name = 'Ludovico'
  user.last_name = 'Hart'
end

competition_series = CompetitionSeries.find_or_create_by!(title: 'EDI 2014')

competitions = {
    'Sunshine' => '2014-02-14',
    'Triptych' => '2014-03-14',
    'Fiddle Photo' => '2014-04-10',
    'Differential Focus' => '2014-05-08',
    'Dangerous' => '2014-06-12'
}

max_dimension = 1200
max_size = 1000

competitions.each do |name, closing_date_string|
  closing_date = Time.parse(closing_date_string)
  publish_date = Time.new(closing_date.year, closing_date.month, closing_date.day, 23, 0)
  competition = Competition.find_or_create_by!(title: closing_date.strftime("%b %Y - #{name}"),
                                               entries_open_at: '2013-01-01',
                                               entries_close_at: closing_date,
                                               results_published_at: publish_date,
                                               competition_series: competition_series
  )

  open_section = competition.sections.find_or_create_by(
      title: 'Open',
      entry_limit: 3,
      max_height: max_dimension,
      max_width: max_dimension,
      max_file_size: max_size
  )

  theme_section = competition.sections.find_or_create_by(
      title: name,
      entry_limit: 1,
      max_height: max_dimension,
      max_width: max_dimension,
      max_file_size: max_size
  )

  Entry.find_or_create_by!(competition: competition, user: user, section: open_section, grade: b_grade) do |entry|
    entry.photo = ActionDispatch::Http::UploadedFile.new(
        tempfile: File.new(Rails.root.join('spec/fixtures/red_umbrella.jpg')),
        filename: File.basename(File.new(Rails.root.join('spec/fixtures/red_umbrella.jpg')))
    )
  end

  Entry.find_or_create_by!(competition: competition, user: user, section: theme_section, grade: b_grade) do |entry|
    entry.photo = ActionDispatch::Http::UploadedFile.new(
        tempfile: File.new(Rails.root.join('spec/fixtures/red_umbrella.jpg')),
        filename: File.basename(File.new(Rails.root.join('spec/fixtures/red_umbrella.jpg')))
    )
  end
end

Rating.find_or_create_by(title: 'Entry', points: 1)
Rating.find_or_create_by(title: 'Commended', points: 3)
Rating.find_or_create_by(title: 'Highly Commended', points: 5)
Rating.find_or_create_by(title: 'Best Colour Photo', points: 6, max_per_competition: 1)
Rating.find_or_create_by(title: 'Best Monochrome Photo', points: 6, max_per_competition: 1)