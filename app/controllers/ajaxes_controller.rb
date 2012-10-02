class AjaxesController < ApplicationController
  def equipment_row
    @equipment = Equipment.find(params[:id])

    render json: {
      result: :success,
      message: "Added #{ @equipment.pretty_name }.",
      row_html: render_ajax_partial
    }
  end

  def render_ajax_partial(options={})
    render_to_string({ partial: params[:action], formats: :html }.merge options)
  end
end
