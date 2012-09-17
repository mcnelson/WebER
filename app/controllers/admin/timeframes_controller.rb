class Admin::TimeframesController < AdminController

  def index
    @timeframes = Timeframe.all

    respond_to do |format|
      format.html
      format.json { render json: @timeframes }
    end
  end

  def show
    @timeframe = Timeframe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @timeframe }
    end
  end

  def new
    @timeframe = Timeframe.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @timeframe }
    end
  end

  def edit
    @timeframe = Timeframe.find(params[:id])
  end

  def create
    @timeframe = Timeframe.new(params[:timeframe])

    respond_to do |format|
      if @timeframe.save
        format.html { redirect_to [:admin, @timeframe], notice: 'Timeframe was successfully created.' }
        format.json { render json: @timeframe, status: :created, location: @timeframe }
      else
        format.html { render action: "new" }
        format.json { render json: @timeframe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @timeframe = Timeframe.find(params[:id])

    respond_to do |format|
      if @timeframe.update_attributes(params[:timeframe])
        format.html { redirect_to [:admin, @timeframe], notice: 'Timeframe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @timeframe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @timeframe = Timeframe.find(params[:id])
    @timeframe.destroy

    respond_to do |format|
      format.html { redirect_to admin_timeframes_url }
      format.json { head :no_content }
    end
  end
end
