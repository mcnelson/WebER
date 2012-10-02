module ApplicationHelper
  def body_class
    "#{params[:controller]} #{params[:controller]}_#{params[:action]}".gsub '/', '_'
  end

  def weekdays_for_select
    Date::DAYNAMES.zip( Date::DAYNAMES.map { |d| d.downcase[0..2] } )
  end

  def js_link(label, options={})
    link_to label, 'javascript:;', options
  end
end
