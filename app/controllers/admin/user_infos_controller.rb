class Admin::UserInfosController < AdminController

  def index
    @user_infos = UserInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_infos }
    end
  end

  def show
    @user_info = UserInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_info }
    end
  end

  def new
    @user_info = UserInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_info }
    end
  end

  def edit
    @user_info = UserInfo.find(params[:id])
  end

  def create
    @user_info = UserInfo.new(params[:user_info])

    respond_to do |format|
      if @user_info.save
        format.html { redirect_to [:admin, @user_info], notice: 'User info was successfully created.' }
        format.json { render json: @user_info, status: :created, location: @user_info }
      else
        format.html { render action: "new" }
        format.json { render json: @user_info.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user_info = UserInfo.find(params[:id])

    respond_to do |format|
      if @user_info.update_attributes(params[:user_info])
        format.html { redirect_to [:admin, @user_info], notice: 'User info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_info.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_info = UserInfo.find(params[:id])
    @user_info.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end
end
