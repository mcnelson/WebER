class Admin::ErHoursController < AdminController
  def new
    @er_hour = ErHour.new
    @er_hour.semester = Semester.find(params[:semester_id]) # nested route
  end

  def edit
    @er_hour = ErHour.find(params[:id])
  end

  def create
    @er_hour = ErHour.new(er_hour_params)
    @er_hour.semester = Semester.find(params[:semester_id])

    if @er_hour.save
      redirect_to edit_admin_semester_path(@er_hour.semester), flash: {success: 'ER Hour was successfully created.'}
    else
      render "new"
    end
  end

  def update
    @er_hour = ErHour.find(params[:id])

    if @er_hour.update_attributes(er_hour_params)
      redirect_to edit_admin_semester_path(@er_hour.semester), flash: {success: 'ER Hour was successfully updated.'}
    else
      render "edit"
    end
  end

  def destroy
    @er_hour = ErHour.find(params[:id])
    @er_hour.destroy

    redirect_to edit_admin_semester_path(@er_hour.semester)
  end

  private

  def er_hour_params
    params.require(:er_hour).permit(%w(starts_at ends_at wday))
  end
end
