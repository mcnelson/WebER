class ErHoursController < ApplicationController
  # GET /er_hours
  # GET /er_hours.json
  def index
    @er_hours = ErHour.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @er_hours }
    end
  end

  # GET /er_hours/1
  # GET /er_hours/1.json
  def show
    @er_hour = ErHour.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @er_hour }
    end
  end

  # GET /er_hours/new
  # GET /er_hours/new.json
  def new
    @er_hour = ErHour.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @er_hour }
    end
  end

  # GET /er_hours/1/edit
  def edit
    @er_hour = ErHour.find(params[:id])
  end

  # POST /er_hours
  # POST /er_hours.json
  def create
    @er_hour = ErHour.new(params[:er_hour])

    respond_to do |format|
      if @er_hour.save
        format.html { redirect_to @er_hour, notice: 'Er hour was successfully created.' }
        format.json { render json: @er_hour, status: :created, location: @er_hour }
      else
        format.html { render action: "new" }
        format.json { render json: @er_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /er_hours/1
  # PUT /er_hours/1.json
  def update
    @er_hour = ErHour.find(params[:id])

    respond_to do |format|
      if @er_hour.update_attributes(params[:er_hour])
        format.html { redirect_to @er_hour, notice: 'Er hour was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @er_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /er_hours/1
  # DELETE /er_hours/1.json
  def destroy
    @er_hour = ErHour.find(params[:id])
    @er_hour.destroy

    respond_to do |format|
      format.html { redirect_to er_hours_url }
      format.json { head :no_content }
    end
  end
end
