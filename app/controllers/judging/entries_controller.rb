class Judging::EntriesController < JudgingController
  def index
    @entries = current_competition.entries
    @competition = current_competition
  end
end
