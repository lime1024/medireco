class MedicalBillsController < ApplicationController
  def index
    @medical_bills = MedicalBill.all
  end

  def show
    @medical_bill = MedicalBill.find(params[:id])
  end

  def new
    @medical_bill = MedicalBill.new
  end

  def edit
    @medical_bill = MedicalBill.find(params[:id])
  end

  def update
    medical_bill = MedicalBill.find(params[:id])
    medical_bill.update!(medical_bill_params)
    redirect_to medical_bills_url, notice: "#{medical_bill.name}の#{medical_bill.payee}を更新しました。"
  end

  def destroy
    medical_bill = MedicalBill.find(params[:id])
    medical_bill.destroy
    redirect_to medical_bills_url, notice: "#{medical_bill.name}の#{medical_bill.payee}を登録しました。"
  end

  def create
    medical_bill = MedicalBill.new(medical_bill_params)
    medical_bill.save!
    redirect_to medical_bills_url, notice: "#{medical_bill.name}の#{medical_bill.payee}を登録しました。"
  end

  private

  def medical_bill_params
    params.require(:medical_bill).permit(:day, :name, :payee, :classification, :cost)
  end
end
