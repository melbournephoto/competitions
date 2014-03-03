class Score
  def initialize(grade)
    @grade = grade
  end

  def results
    @results = {}
    @grade.entries.joins(:competition).where('results_published_at < now()').each do |entry|
      @results[entry.user_id] = {user: entry.user, total: 0, competitions: {}} unless @results[entry.user_id]

      @results[entry.user_id][:competitions][entry.competition_id] = [] unless @results[entry.user_id][:competitions][entry.competition_id]

      @results[entry.user_id][:competitions][entry.competition_id] << entry
      @results[entry.user_id][:total] += entry.points
    end

    @results = @results.values

    @results.sort! { |y,x| x[:total] <=> y[:total] }

    @results
  end
end