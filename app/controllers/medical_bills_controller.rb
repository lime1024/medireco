class MedicalBillsController < ApplicationController
  before_action :set_medical_bill, only: [:show, :edit, :update, :destroy]
  def index
    @medical_bills = current_user.medical_bills.preload(:family_member, :payee).order(day: :desc).page(params[:page]).per(10)

    today_year = Date.today.year
    this_year = current_user.medical_bills.where("day BETWEEN ? AND ?", "#{today_year}-01-01", "#{today_year}-03-31")
    @this_year_total_cost = this_year.sum(:cost)
  end

  def show
  end

  def new
    @medical_bill = MedicalBill.new
  end

  def edit
  end

  def update
    @medical_bill.update!(medical_bill_params)
    redirect_to medical_bills_path, notice: "#{@medical_bill.day} #{@medical_bill.family_member.name}の#{@medical_bill.classification}を更新しました。"
  end

  def destroy
    @medical_bill.destroy
    redirect_to medical_bills_path, notice: "#{@medical_bill.day} #{@medical_bill.family_member.name}の#{@medical_bill.classification}を削除しました。"
  end

  def create
    @medical_bill = current_user.medical_bills.new(medical_bill_params)
    
    if @medical_bill.save
      redirect_to @medical_bill, notice: "#{@medical_bill.day} #{@medical_bill.family_member.name}の#{@medical_bill.classification}を登録しました。"
    else
      render :new
    end
  end

  def output
    @medical_bills = current_user.medical_bills.search(params[:year])
    @total_cost = current_user.medical_bills.sum(:cost)

    @workbook = RubyXL::Parser.parse(Rails.root.join("template", "template.xlsx"))
    @sheet = @workbook.first

    @sheet[2][2].change_contents(@total_cost) # 合計金額
    
    num = 8
    @medical_bills.each.with_index(1){ |medical_bill, index|
      if medical_bill.classification == "治療費"
        @sheet[num][0].change_contents(index) # No.
        @sheet[num][1].change_contents(medical_bill.family_member.name) # 名前
        @sheet[num][2].change_contents(medical_bill.payee.name) # 支払先
        @sheet[num][3].change_contents("該当する") # 区分
        @sheet[num][7].change_contents(medical_bill.cost) # 金額
      elsif medical_bill.classification == "医薬品費"
        @sheet[num][0].change_contents(index) # No.
        @sheet[num][1].change_contents(medical_bill.family_member.name) # 名前
        @sheet[num][2].change_contents(medical_bill.payee.name) # 支払先
        @sheet[num][4].change_contents("該当する") # 区分
        @sheet[num][7].change_contents(medical_bill.cost) # 金額
      elsif medical_bill.classification == "交通費"
        @sheet[num][0].change_contents(index) # No.
        @sheet[num][1].change_contents(medical_bill.family_member.name) # 名前
        @sheet[num][2].change_contents(medical_bill.payee.name) # 支払先
        @sheet[num][6].change_contents("該当する") # 区分
        @sheet[num][7].change_contents(medical_bill.cost) # 金額        
      end
      num += 1
    }

    filename = SecureRandom.urlsafe_base64(8)
    respond_to do |format|
      format.xlsx do
        send_data(@workbook.stream.read, filename: "#{filename}.xlsx")
      end
    end
    ensure
      @workbook.stream.close
    end

  private

  def medical_bill_params
    params.require(:medical_bill).permit(:day, :family_member_id, :payee_id, :classification, :cost)
  end

  def set_medical_bill
    @medical_bill = current_user.medical_bills.find(params[:id])
  end
end
