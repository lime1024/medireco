require 'rubyXL/convenience_methods'

class MedicalBillOutput
  def initialize(user:, year:)
    @medical_bills = user.medical_bills.search(year).summarized_output
    @total_cost = user.medical_bills.sum(:cost)
  end

  def as_xlsx
    workbook = RubyXL::Parser.parse(Rails.root.join("template", "template.xlsx"))
    sheet = workbook.first

    sheet[2][2].change_contents(@total_cost) # 合計金額
    
    num = 8

    @medical_bills.each.with_index(1) do |medical_bill, index|
      sheet[num][0].change_contents(index) # No.
      sheet[num][1].change_contents(medical_bill[0][0]) # 名前
      sheet[num][2].change_contents(medical_bill[0][1]) # 支払先
      sheet[num][7].change_contents(medical_bill[1]) # 金額
      case medical_bill[0][2] # 区分
      when "治療費"
        sheet[num][3].change_contents("該当する")
      when "医薬品費"
        sheet[num][4].change_contents("該当する")
      when "交通費"
        sheet[num][6].change_contents("該当する") 
      end
      num += 1
    end
    
    return workbook
  end
end
