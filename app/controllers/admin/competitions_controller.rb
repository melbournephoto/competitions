require 'csv'

class Admin::CompetitionsController < ApplicationController
  def index
    @competitions = Competition.all.ordered
  end

  def show
    @competition = Competition.find(params[:id])
    respond_to do |format|
      format.html
      format.csv do
        csv_string = CSV.generate do |csv|
          csv << ["filename", "entry title", "section", "entrant"]
          @competition.entries.each do |entry|
            csv << [sprintf('%.10d', entry.order) + '.jpg', entry.title, entry.section.title, entry.user.name]
          end
        end

        send_data csv_string, filename: @competition.title + '.csv'
      end
    end
  end

  def new
    @competition = Competition.new
  end

  def create
    @competition = Competition.new(competition_params)
    if @competition.save
      redirect_to admin_competition_path(@competition), notice: 'Competition created'
    else
      render action: 'new'
    end
  end

  def edit
    @competition = Competition.find(params[:id])
  end

  def update
    @competition = Competition.find(params[:id])
    if @competition.update_attributes(competition_params)
      redirect_to admin_competition_path(@competition), notice: 'Competition updated'
    else
      render action: 'edit'
    end
  end

  private
  def competition_params
    params.require(:competition).permit(:title, :entries_open_at, :entries_close_at, :results_published_at, :notes, :entry_limit)
  end
end
