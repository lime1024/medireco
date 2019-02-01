class MedicalBillsController < ApplicationController
  def index
    @total_cost = MedicalBill.sum(:cost)
    @medical_bills = MedicalBill.search(params[:search])
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
    redirect_to root_url, notice: "#{medical_bill.day} #{medical_bill.name}の#{medical_bill.classification}を更新しました。"
  end

  def destroy
    medical_bill = MedicalBill.find(params[:id])
    medical_bill.destroy
    redirect_to root_url, notice: "#{medical_bill.day} #{medical_bill.name}の#{medical_bill.classification}を登録しました。"
  end

  def create
    medical_bill = MedicalBill.new(medical_bill_params)
    medical_bill.save!
    redirect_to root_url, notice: "#{medical_bill.day} #{medical_bill.name}の#{medical_bill.classification}を登録しました。"
  end

  def output
    @medical_bills = MedicalBill.search(params[:search])
    @total_cost = MedicalBill.sum(:cost)

    @workbook = RubyXL::Parser.parse(Rails.root.join("template", "template.xlsx"))
    @sheet = @workbook.first

    @sheet[2][2].change_contents(@total_cost) # 合計金額
    
    num = 8
    @medical_bills.each.with_index(1){ |medical_bill, index|
      if medical_bill.classification == "治療費"
        @sheet[num][0].change_contents(index) # No.
        @sheet[num][1].change_contents(medical_bill.name) # 名前
        @sheet[num][2].change_contents(medical_bill.payee) # 支払先
        @sheet[num][3].change_contents("該当する") # 区分
        @sheet[num][7].change_contents(medical_bill.cost) # 金額
      elsif medical_bill.classification == "医薬品費"
        @sheet[num][0].change_contents(index) # No.
        @sheet[num][1].change_contents(medical_bill.name) # 名前
        @sheet[num][2].change_contents(medical_bill.payee) # 支払先
        @sheet[num][4].change_contents("該当する") # 区分
        @sheet[num][7].change_contents(medical_bill.cost) # 金額
      elsif medical_bill.classification == "交通費"
        @sheet[num][0].change_contents(index) # No.
        @sheet[num][1].change_contents(medical_bill.name) # 名前
        @sheet[num][2].change_contents(medical_bill.payee) # 支払先
        @sheet[num][6].change_contents("該当する") # 区分
        @sheet[num][7].change_contents(medical_bill.cost) # 金額        
      end
      num += 1
    }

    filename = SecureRandom.urlsafe_base64(8)
    @workbook.write(Rails.root.join("tmp", "#{filename}.xlsx"))
    send_file(Rails.root.join("tmp", "#{filename}.xlsx"))
  end

  def last_year_output
    this_year = Date.today.year
    last_year = this_year - 1
    @medical_bills_last_year_output = MedicalBill.where("day BETWEEN ? AND ?", "#{last_year}-01-01", "#{last_year}-03-31")

    @total_cost = @medical_bills_last_year_output.sum(:cost)

    @workbook = RubyXL::Parser.parse(Rails.root.join("template", "template.xlsx"))
    @sheet = @workbook.first

    @sheet[2][2].change_contents(@total_cost) # 合計金額

    num = 8
    @medical_bills_last_year_output.each.with_index(1){ |medical_bill, index|
      if medical_bill.classification == "治療費"
        @sheet[num][0].change_contents(index) # No.
        @sheet[num][1].change_contents(medical_bill.name) # 名前
        @sheet[num][2].change_contents(medical_bill.payee) # 支払先
        @sheet[num][3].change_contents("該当する") # 区分
        @sheet[num][7].change_contents(medical_bill.cost) # 金額
      elsif medical_bill.classification == "医薬品費"
        @sheet[num][0].change_contents(index) # No.
        @sheet[num][1].change_contents(medical_bill.name) # 名前
        @sheet[num][2].change_contents(medical_bill.payee) # 支払先
        @sheet[num][4].change_contents("該当する") # 区分
        @sheet[num][7].change_contents(medical_bill.cost) # 金額
      elsif medical_bill.classification == "交通費"
        @sheet[num][0].change_contents(index) # No.
        @sheet[num][1].change_contents(medical_bill.name) # 名前
        @sheet[num][2].change_contents(medical_bill.payee) # 支払先
        @sheet[num][6].change_contents("該当する") # 区分
        @sheet[num][7].change_contents(medical_bill.cost) # 金額        
      end
      num += 1
    }

    filename = SecureRandom.urlsafe_base64(8)
    @workbook.write(Rails.root.join("tmp", "#{filename}.xlsx"))
    send_file(Rails.root.join("tmp", "#{filename}.xlsx"))
  end

  def last_year_delete
    this_year = Date.today.year
    last_year = this_year - 1
    @medical_bills_delete = MedicalBill.where("day BETWEEN ? AND ?", "#{last_year}-01-01", "#{last_year}-03-31").destroy_all
    redirect_to root_url
  end

  private

  def medical_bill_params
    params.require(:medical_bill).permit(:day, :name, :payee, :classification, :cost)
  end
end
