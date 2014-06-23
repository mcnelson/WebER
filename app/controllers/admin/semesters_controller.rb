class Admin::SemestersController < AdminController
  def index
    @semesters = Semester.page(params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @semesters }
    end
  end

  def show
    @semester = Semester.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @semester }
    end
  end

  def new
    @semester = Semester.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @semester } end end

  def edit
    @semester = Semester.find(params[:id])
  end

  def create
    @semester = Semester.new(semester_params)

    respond_to do |format|
      if @semester.save
        format.html { redirect_to [:admin, @semester], notice: 'Semester was successfully created.' }
        format.json { render json: @semester, status: :created, location: @semester }
      else
        format.html { render action: "new" }
        format.json { render json: @semester.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @semester = Semester.find(params[:id])

    respond_to do |format|
      if @semester.update_attributes(semester_params)
        format.html { redirect_to [:admin, @semester], notice: 'Semester was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @semester.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def semester_params
    params.require(:semester).permit(%w(starts_at ends_at))
  end
end
