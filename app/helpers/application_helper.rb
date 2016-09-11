module ApplicationHelper
  def additional_javascripts
    @_additional_javascripts || []
  end

  def javascript_includes
    additional_javascripts.map do |script|
      javascript_include_tag script[:src]
    end.join.html_safe
  end

  def partial_name_for_history(history)
    "#{history.class.name.underscore}_form"
  end
end
