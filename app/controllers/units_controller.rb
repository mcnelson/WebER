class UnitsController < ApplicationController
  def forty_image
    unit = Unit.find(params[:unit_id])
    render text: unit.photo.url(:forty)

  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
