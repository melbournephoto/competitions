class RootController < ApplicationController
  def index
    @competition_series = CompetitionSeries.find_by_sql(['select distinct competition_series.id, competition_series.title from competition_series
inner join sections on competition_series.id=sections.competition_series_id
inner join competitions on sections.competition_id=competitions.id
where results_published_at between ? and ?', Time.now.beginning_of_year, Time.now.end_of_year])
  end
end
