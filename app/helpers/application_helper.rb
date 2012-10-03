module ApplicationHelper
  def set_title(title)
    content_for(:full_title) { "#{ title } - WebER" }
    content_for(:page_title) { title }
  end

  def weekdays_for_select
    Date::DAYNAMES.zip( Date::DAYNAMES.map { |d| d.downcase[0..2] } )
  end

  def js_link(label, options={})
    link_to label, 'javascript:;', options
  end
end
