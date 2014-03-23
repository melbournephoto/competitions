module Admin::CompetitionsHelper
  def entry_class(entry)
    if entry.points > 1
      'entry-awarded'
    else
      'entry-no-award'
    end
  end
end
