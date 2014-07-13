class Admin::UsersController < AdminController
  before_filter :require_admin

  def index
    @users = User.page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to [:admin, @user], flash: {success: 'User info was successfully created.'}
    else
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to [:admin, @user], flash: {success: 'User info was successfully updated.'}
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :punet, :password, :password_confirmation, :active, :permission_level, :can_reserve, :email,
      :pu_student_id, :strikes, :notes
    )
  end
end
