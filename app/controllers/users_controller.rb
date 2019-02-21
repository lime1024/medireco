class UsersController < ApplicationController
  skip_before_action :login_required
  before_acition : set_user, only: [:edit, :show, :update, :destroy]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to medical_bills_path, notice: "ユーザ #{@user.name} を登録しました"
    else
      render :new
    end
  end
  
  def edit
  end

  def show
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "ユーザ #{@user.name} を更新しました"
    else
      render :new
    end
  end
  
  def destroy
    @user.destroy
    redirect_to root_path, notice: "ユーザ #{@user.name} を削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
