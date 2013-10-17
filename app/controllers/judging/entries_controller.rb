class Judging::EntriesController < JudgingController
  def index
    @entries = current_competition.entries
    @competition = current_competition
  end

  def edit
    @entry = current_competition.entries.find(params[:id])
  end

  def update
    @entry = current_competition.entries.find(params[:id])
    @entry.update_attributes(entry_params)

    next_entry = current_competition.entries.not_rated.first
    if params.include?(:next_unrated) && next_entry
      redirect_to edit_judging_entry_path(next_entry)
    else
      redirect_to judging_entries_path
    end
  end

  private
  def entry_params
    params.require(:entry).permit(:rating_id, :notes)
  end
end
