class AdminController < ApplicationController
  layout 'admin'

  before_filter :check_permissions

  def check_permissions
  end
end
