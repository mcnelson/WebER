module Admin::UsersHelper
  def active_label(user)
    if user.active
      content_tag :span, "Active", class: "label label-success"
    else
      content_tag :span, "Inactive", class: "label label-inverse"
    end
  end
end
