module ApplicationHelper
  def set_title(title)
    content_for(:full_title) { "#{ title } - WebER" }
    content_for(:page_title) { title }
  end

  def set_crud_title(action, record_instance, title = nil)
    formatted_title = if title
      ": " << (title.present? ? title : "(unnamed)")
    else
      ""
    end

    set_title("#{action.to_s.capitalize} #{record_instance.class.model_name.human}#{formatted_title}")
  end

  def form_errors(object)
    if ["text/javascript", "data/json"].include? request.format
      render partial: "ajax_errors", locals: { object: object }
    else
      render partial: "form_errors", locals: { object: object }
    end
  end

  def weekdays_for_select
    Date::DAYNAMES.each_with_index.map do |dayname, wday|
      [dayname, wday]
    end
  end

  def js_link(label, options={})
    link_to label, 'javascript:;', options
  end

  def body_class
    "#{params[:controller].gsub(/\//, '_')} #{params[:controller].gsub(/\//, '_')}_#{params[:action]}"
  end

  def user_bar
    render partial: "user_bar"
  end

  def nav_link_to(label, path, opts={})
    p = Rails.application.routes.recognize_path path

    opts = opts.merge({ class: "nav-current" }) if controller.controller_name == p[:controller].gsub(/^.*\//, '')

    link_to label, path, opts
  end

  def grouped_units_select_options(category_class = nil)
    result = {}

    query = Category.order(:title)
    query = query.where(type: category_class) if (category_class != nil)

    # Grab all categories
    query.all.each do |category|
      result[category.units.all.sort_by { |e| e.name_brand_model }] = category.title
    end

    result
  end

  def equipment_statuses_for_select
    Equipment::STATUSES.map { |s| [s.capitalize, s] }
  end

  def sortable(column, title = nil)
    title ||= column.to_s.titleize

    link_class = ""
    link_href = ""
    link_inner = ""

    if column.to_s == sort_column.to_s
      case sort_direction
        when "asc"
          link_class = "current asc"
          link_href = params.merge sort: column, direction: "desc", page: nil
          link_inner = "#{ title }<i class=\"icon-chevron-up\"></i>"

        when "desc"
          link_class = "current desc"
          link_href = params.merge sort: column, direction: "asc", page: nil
          link_inner = "#{ title }<i class=\"icon-chevron-down\"></i>"

        else
          link_class = ""
          link_href = nil
          link_inner = "#{ title }"
      end
    else
      link_class = ""
      link_href = params.merge sort: column, direction: "asc", page: nil
      link_inner = "#{ title }"
    end

    link_to link_href, { class: link_class} do
      link_inner.html_safe
    end
  end
end
