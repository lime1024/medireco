class MedicalBillsController < ApplicationController
  before_action :set_medical_bill, only: [:show, :edit, :update, :destroy]
  def index
    respond_to do |format|
      format.html do
        @medical_bills = current_user.medical_bills.preload(:family_member, :payee).recent.page(params[:page])
        render :index
      end
      format.xlsx do
        if params[:year].blank?
          redirect_to medical_bills_path(format: :html), notice: "出力年を選択してください"
          return
        end
        output = MedicalBillOutput.new(user: current_user, year: params[:year])
        begin
          workbook = output.as_xlsx
          filename = SecureRandom.urlsafe_base64(8)
          send_data(workbook.stream.read, filename: "#{filename}.xlsx")
        ensure
          workbook.stream.close
        end
      end
    end
  end

  def new
    @medical_bill = MedicalBill.new
  end

  def edit
  end

  def update
    if @medical_bill.update(medical_bill_params)
      redirect_to medical_bills_path, notice: "#{@medical_bill.day} #{@medical_bill.family_member.name}の#{@medical_bill.classification}を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @medical_bill.destroy
    redirect_to medical_bills_path, notice: "#{@medical_bill.day} #{@medical_bill.family_member.name}の#{@medical_bill.classification}を削除しました"
  end

  def create
    @medical_bill = current_user.medical_bills.new(medical_bill_params)
    
    if @medical_bill.save
      redirect_to medical_bills_path, notice: "#{@medical_bill.day} #{@medical_bill.family_member.name}の#{@medical_bill.classification}を登録しました"
    else
      render :new
    end
  end

  private

  def medical_bill_params
    params.require(:medical_bill).permit(:day, :family_member_id, :payee_id, :classification, :cost)
  end

  def set_medical_bill
    @medical_bill = current_user.medical_bills.find(params[:id])
  end
end
