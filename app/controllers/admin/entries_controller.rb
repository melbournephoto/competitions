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
      redirect_to admin_entry_path(@entry), notice: 'The entry has been updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.update_attribute :deleted_at, Time.now
    redirect_to admin_entry_path(@entry)
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :entry_section_id, :photo_cache, :photo, :grade_id)
  end
end
