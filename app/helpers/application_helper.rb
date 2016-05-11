module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    if column != sort_column
      css_class = nil
    elsif sort_direction == "ASC"
      css_class = "current glyphicon glyphicon-triangle-top"
    else
      css_class = "current glyphicon glyphicon-triangle-bottom"
    end
    direction = sort_direction == "ASC" ? "DESC" : "ASC"
    link_to "#{title} <span class='#{css_class}'></span>".html_safe, {:sort => column, :direction => direction}
  end
end
