class UnknownClassificationError < StandardError
end

class ClassificationMigrator
  def self.execute
    ActiveRecord::Base.transaction do
      treatment_cost = Classification.find_by!(name: '治療費')
      medicine_cost = Classification.find_by!(name: '医薬品費')
      travel_cost = Classification.find_by!(name: '交通費')

      MedicalBill.find_each do |medical_bill|
        case medical_bill.classification
        when '治療費'
          medical_bill.classification_id = treatment_cost.id
        when '医薬品費'
          medical_bill.classification_id = medicine_cost.id
        when '交通費'
          medical_bill.classification_id = travel_cost.id
        else
          raise UnknownClassificationError, "#{medical_bill.id}: #{medical_bill.classification}"
        end

        medical_bill.save!
      end
    end
  end
end
