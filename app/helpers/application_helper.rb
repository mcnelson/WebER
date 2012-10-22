module ApplicationHelper
  def set_title(title)
    content_for(:full_title) { "#{ title } - WebER" }
    content_for(:page_title) { title }
  end

  def form_errors(object)
    render partial: "form_errors", locals: { object: object }
  end

  def weekdays_for_select
    Date::DAYNAMES.zip( Date::DAYNAMES.map { |d| d.downcase[0..2] } )
  end

  def js_link(label, options={})
    link_to label, 'javascript:;', options
  end

  def body_class
    "#{ params[:controller].gsub(/\//, '_') }_#{ params[:action] }"
  end

  def user_bar
    render partial: "user_bar"
  end

  def sortable(column, title = nil)
    title ||= column.titleize

    link_class = ""
    link_href = ""
    link_inner = ""

    if column == sort_column
      case sort_direction
        when "asc"
          link_class = "current asc"
          link_href = params.merge sort: column, direction: "desc", page: nil
          link_inner = "#{ column }<i class=\"icon-chevron-up\"></i>"

        when "desc"
          link_class = "current desc"
          link_href = nil # self
          link_inner = "#{ column }<i class=\"icon-chevron-down\"></i>"

        else
          link_class = ""
          link_href = params.merge sort: column, direction: "asc", page: nil
          link_inner = "#{ column }"
      end
    else
      link_class = ""
      link_href = params.merge sort: column, direction: "asc", page: nil
      link_inner = "#{ column }"
    end


    link_to link_href, { class: link_class} do
      link_inner.html_safe
    end
  end

  def nav_link_to(label, path, opts={})
    p = Rails.application.routes.recognize_path path

    opts = opts.merge({ class: "nav-current" }) if controller.controller_name == p[:controller].gsub(/^.*\//, '')

    link_to label, path, opts
  end
end
