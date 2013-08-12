class SectionsController < ApplicationController
  before_filter :require_admin

  def new
    @section = competition.sections.new
  end

  def create
    @section = competition.sections.new(section_params)
    if @section.save
      redirect_to competition
    else
      render action: 'new'
    end
  end

  def edit
    @section = competition.sections.find(params[:id])
  end

  def update
    @section = competition.sections.find(params[:id])
    if @section.update_attributes(section_params)
      redirect_to competition
    else
      render action: 'edit'
    end
  end

  private
  def competition
    @competition ||= Competition.find(params[:competition_id])
  end

  def section_params
    params.require(:section).permit(:title, :entry_limit, :max_height, :max_width, :max_file_size)
  end

end
