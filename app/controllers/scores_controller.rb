require 'csv'

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
    respond_to do |format|
      format.html
      format.csv do
        csv_string = CSV.generate do |csv|
          csv << [''] + @grade.competition_series.sections.map { |s| s.competition.title } + ['Total']
          @scores.results.each do |result|
            row = []
            row << result[:user].name
            @grade.competition_series.sections.each do |section|
              cell = ""
              if result[:competitions][section.competition_id].present?
                result[:competitions][section.competition_id].each do |entry|
                  cell += entry.short_rating
                end
              end
              row << cell
            end
            row << result[:total]
            csv << row
          end
        end

        send_data(csv_string, type: 'text/csv', disposition: 'inline')
      end
    end
  end
end
