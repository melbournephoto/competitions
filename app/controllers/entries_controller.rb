class EntriesController < ApplicationController
  before_filter :validate_competition
  before_filter :validate_user_grade

  attr_reader :competition

  def new
    @entry = @competition.entries.new(user: current_user)
  end

  def create
    @entry = @competition.entries.new(entry_params)
    @entry.user = current_user
    @entry.grade = CompetitionSeriesGrade.find_by(competition_series: @entry.section.competition_series, user: current_user).grade

    if @entry.save
      redirect_to @competition
    else
      render action: 'new'
    end
  end

  def edit
    @entry = current_user.entries.find(params[:id])
  end

  def update
    @entry = current_user.entries.find(params[:id])
    if @entry.update_attributes(entry_params)
      redirect_to @entry.competition
    else
      render action: 'edit'
    end
  end

  def destroy
    @entry = current_user.entries.find(params[:id])
    @entry.destroy
    redirect_to @entry.competition, notice: 'Your entry has been deleted'
  end

  private
  def validate_competition
    @competition = Competition.find(params[:competition_id])
    redirect_to @competition unless @competition.open_for_entry?
  end

  def validate_user_grade
    @competition.sections.each do |section|
      @comp_grade = CompetitionSeriesGrade.find_by(user: current_user, competition_series: section.competition_series)
      unless @comp_grade
        redirect_to edit_competition_series_grade_path(section.competition_series, competition_id: @competition), notice: 'You must select your grade before continuing'
        return
      end
    end
  end

  def entry_params
    params.require(:entry).permit(:title, :photo, :section_id, :photo_cache)
  end
end
