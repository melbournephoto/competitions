class ScoresController < ApplicationController
  def index
    @competition_series = CompetitionSeries.find_by_sql(['select distinct competition_series.id, competition_series.title from competition_series
inner join sections on competition_series.id=sections.competition_series_id
inner join competitions on sections.competition_id=competitions.id
where results_published_at < ?', Time.now])

  end

  def show
    @grade = Grade.find(params[:id])

    @scores = Score.new(@grade)
  end
end
