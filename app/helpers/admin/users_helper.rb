module Admin::UsersHelper
  def select_for_series(competition_series)
    competition_series[:user_grade].try(:title)

    options = ""
    unless competition_series[:user_grade]
      options << "<option/>"
    end
    options += options_from_collection_for_select(competition_series[:grades], 'id', 'title', competition_series[:user_grade].try(:id))

    select_tag("user[competition_series][#{competition_series[:competition_series].id}]", options.html_safe).html_safe
  end
end
