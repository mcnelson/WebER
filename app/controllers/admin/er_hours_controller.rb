class Admin::ErHoursController < AdminController

  def new
    @er_hour = ErHour.new

    # Nested route, so we need to tell it what semester
    @er_hour.semester = Semester.find(params[:semester_id])
  end

  def edit
    @er_hour = ErHour.find(params[:id])
  end

  def create
    @er_hour = ErHour.new(params[:er_hour])
    @er_hour.semester = Semester.find(params[:semester_id])

    if @er_hour.save
      redirect_to edit_admin_semester_path(@er_hour.semester), notice: 'ER Hour was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @er_hour = ErHour.find(params[:id])

    if @er_hour.update_attributes(params[:er_hour])
      redirect_to edit_admin_semester_path(@er_hour.semester), notice: 'ER Hour was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @er_hour = ErHour.find(params[:id])
    @er_hour.destroy

    redirect_to edit_admin_semester_path(@er_hour.semester)
  end
end
