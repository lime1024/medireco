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
      if params[:payee][:from] == 'medical_bill'
        redirect_to new_medical_bill_path
      else
        redirect_to user_payees_path, notice: "#{@payee.name} を登録しました"
      end
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
    if @payee.errors.present?
      redirect_to user_payees_path, notice: "#{@payee.name} は関連する医療費があるため、削除できませんでした" 
    else
      redirect_to user_payees_path, notice: "#{@payee.name} を削除しました"
    end
  end

  private

  def payee_params
    params.require(:payee).except(:from).permit(:name)
  end

  def set_payee
    @payee = current_user.payees.find(params[:id])
  end
end
