class Admin::EntriesController < AdminController
  def new
    @entry = Entry.new(competition_id: params[:competition_id])
  end

  def create
    @entry = Entry.new(params.require(:entry).permit(:user_id, :title, :section_id, :photo, :competition_id))

    if @entry.section
      @entry.grade = CompetitionSeriesGrade.find_by(competition_series: @entry.section.competition_series, user: @entry.user).grade
    end

    if @entry.competition.entry_limit > 0 && @competition.entries.where(user: entry.user).count >= @entry.competition.entry_limit
      @entry.errors.add(:section_id, 'Competition entry limit reached')
      render action: 'new'
      return
    end

    if @entry.save
      redirect_to admin_entry_path(@entry)
    else
      render action: 'new'
    end
  end

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
    params.require(:entry).permit(:title, :entry_section_id, :photo_cache, :photo, :grade_id, :rating_id)
  end
end
