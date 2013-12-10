class Judging::EntriesController < JudgingController
  def index
    @competition = current_competition
    @entries = @competition.entries.ordered.includes(:rating)

    @rating_counts = []
    @entries.count(:group => "rating_id").each do |rating_id, count|
      rating_title = rating_id.nil? ? 'No Rating' : Rating.find(rating_id).title
      @rating_counts << {
          title: rating_title,
          rating_id: 'rating-' + rating_id.to_s,
          count: count
      }
    end

    @grade_counts = []
    @entries.count(:group => "grade_id").each do |grade_id, count|
      @grade_counts << {
          title: Grade.find(grade_id).title,
          grade_id: 'grade-' + grade_id.to_s,
          count: count
      }
    end
  end

  def edit
    @entry = current_competition.entries.find(params[:id])
  end

  def update
    @entry = current_competition.entries.find(params[:id])
    @entry.update_attributes(entry_params)

    next_entry = current_competition.entries.not_rated.ordered.first
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
