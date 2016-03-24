module ApplicationHelper
  def partial_name_for_history(history)
    "#{history.class.name.underscore}_form"
  end
end
