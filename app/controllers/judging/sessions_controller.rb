class Judging::SessionsController < JudgingController
  skip_before_filter :authenticate_judge!

  def show
    competition = Competition.where('results_published_at > ?', Time.now).find_by_judge_key(params[:id])
    if competition
      session[:judging_competition_id] = competition.id
      redirect_to judging_entries_path
    else
      render action: 'invalid_key'
    end
  end
end
