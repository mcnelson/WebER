class AdminController < ApplicationController
  layout 'admin'

  before_filter :require_workstudy
end
