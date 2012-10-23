class Admin::ErHoursController < AdminController

  def new
    @er_hour = ErHour.new
    @associated_hours = ErHour.where(semester_id: params[:semester_id]).all

    # Nested route, so we need to tell it what semester
    @er_hour.semester = Semester.find params[:semester_id]


    respond_to do |format|
      format.html
      format.json { render json: @er_hour }
    end
  end

  def edit
    @er_hour = ErHour.find(params[:id])
    @associated_hours = ErHour.live_excluding(@er_hour).all
  end

  def create
    @er_hour = ErHour.new(params[:er_hour])

    respond_to do |format|
      if @er_hour.save
        format.html { redirect_to edit_admin_semester_path(@er_hour.semester), notice: 'Er hour was successfully created.' }
        format.json { render json: @er_hour, status: :created, location: @er_hour }
      else
        format.html { render action: "new" }
        format.json { render json: @er_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @er_hour = ErHour.find(params[:id])

    respond_to do |format|
      if @er_hour.update_attributes(params[:er_hour])
        format.html { redirect_to edit_admin_semester_path(@er_hour.semester), notice: 'Er hour was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @er_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @er_hour = ErHour.find(params[:id])
    @er_hour.destroy

    respond_to do |format|
      format.html { redirect_to edit_admin_semester_path(@er_hour.semester) }
      format.json { head :no_content }
    end
  end
end
