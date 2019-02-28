class PayeesController < ApplicationController
  before_action :set_payee, only: [:edit, :show, :update, :destroy]
  
  def index
    @payees = current_user.payees
  end

  def new
    @payee = Payee.new
  end

  def create
    @payee = current_user.payees.new(payee_params)

    if @payee.save
      redirect_to user_payees_path, notice: "#{@payee.name} を登録しました"
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @payee.update(payee_params)
      redirect_to user_payees_path, notice: "#{@payee.name} を更新しました"
    else
      render :new
    end
  end
  
  def destroy
    @payee.destroy
    redirect_to user_payees_path, notice: "#{@payee.name} を削除しました"
  end

  private

  def payee_params
    params.require(:payee).permit(:name)
  end

  def set_payee
    @payee = current_user.payees.find(params[:id])
  end
end
