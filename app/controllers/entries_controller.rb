class EntriesController < ApplicationController
  before_filter :validate_competition

  attr_reader :competition

  def new
    @entry = @competition.entries.new(user: current_user)
  end

  def create
    @entry = @competition.entries.new(entry_params)
    @entry.user = current_user

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
  private
  def validate_competition
    @competition = Competition.find(params[:competition_id])
    redirect_to @competition unless @competition.open_for_entry?
  end

  def entry_params
    params.require(:entry).permit(:title, :photo, :section_id, :photo_cache)
  end
end
