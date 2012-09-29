class Admin::UserInfosController < AdminController

  def index
    @users = UserInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user}
    end
  end

  def show
    @user = UserInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user}
    end
  end

  def new
    @user = UserInfo.new

    respond_to do |format|
      format.html
      format.json { render json: @user}
    end
  end

  def edit
    @user = UserInfo.find(params[:id])
  end

  def create
    @user = UserInfo.new(params[:user_info])

    respond_to do |format|
      if @user.save
        format.html { redirect_to [:admin, @user], notice: 'User info was successfully created.' }
        format.json { render json: @user, status: :created, location: @user_info }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = UserInfo.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to [:admin, @user], notice: 'User info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = UserInfo.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end
end
