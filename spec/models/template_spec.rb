require 'rails_helper'

RSpec.describe Template do
  it 'テンプレートに名前があること' do
    template = Template.create(name: 'おさかな病院のテンプレート')

    expect(template.name).to eq 'おさかな病院のテンプレート'
  end

  it 'テンプレートには治療費・医薬品費・交通費がまとめて登録できること' do
    treatment_cost = FactoryBot.create(:classification, name: '治療費')
    medicine_cost = FactoryBot.create(:classification, name: '医薬品費')
    travel_cost = FactoryBot.create(:classification, name: '交通費')
    user = FactoryBot.create(:user)
    family_member = FactoryBot.create(:family_member, user: user)
    hospital = FactoryBot.create(:payee, name: 'おさかな病院', user: user)
    public_transport_1 = FactoryBot.create(:payee, name: '鮮魚交通', user: user)
    public_transport_2 = FactoryBot.create(:payee, name: '海鮮バス', user: user)

    template = Template.create(name: 'おさかな病院のテンプレート')

    TemplateRecord.create(
      cost: 1430,
      classification_id: treatment_cost.id,
      family_member_id: family_member.id,
      payee_id: hospital.id,
      user_id: user.id,
      template_id: template.id
    )
    TemplateRecord.create(
      cost: nil,
      classification_id: medicine_cost.id,
      family_member_id: family_member.id,
      payee_id: hospital.id,
      user_id: user.id,
      template_id: template.id
    )
    TemplateRecord.create(
      cost: 360,
      classification_id: travel_cost.id,
      family_member_id: family_member.id,
      payee_id: public_transport_1.id,
      user_id: user.id,
      template_id: template.id
    )
    TemplateRecord.create(
      cost: 120,
      classification_id: travel_cost.id,
      family_member_id: family_member.id,
      payee_id: public_transport_2.id,
      user_id: user.id,
      template_id: template.id
    )

    expect(template.template_records.size).to eq 4
  end
end
