task copy_grades: :environment do
  from_comp_series = CompetitionSeries.find(ENV['FROM'])
  to_comp_series = CompetitionSeries.find(ENV['TO'])

  User.all.each do |user|
    to_comp_series_grade = user.competition_series_grades.find_by(competition_series_id: to_comp_series.id)

    if to_comp_series_grade
      puts "User #{user.name} already grade #{to_comp_series_grade.grade.title}"
      next
    end

    from_comp_series_grade = user.competition_series_grades.find_by(competition_series_id: from_comp_series.id)
    next unless from_comp_series_grade
    puts "#{user.name} #{from_comp_series_grade.grade.title}"
    new_grade = to_comp_series.grades.find_by(title: from_comp_series_grade.grade.title)
    unless new_grade
      puts "Grade not found in destination"
      next
    end

    user.competition_series_grades.create!(competition_series: to_comp_series, grade: new_grade)
  end

end