class Admin::EntriesController < AdminController
  def show
    @entry = Entry.find(params[:id])
  end
  
  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(entry_params)
      redirect_to admin_competition_path(@entry.competition), notice: 'The entry has been updated'
    else
      render action: 'edit'
    end
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :entry_section_id, :photo_cache, :photo, :grade_id)
  end
end
