require 'rails_helper'

RSpec.describe 'Classification' do
  it '支払先が 3 種類あること' do
    treatment_cost = Classification.create(name: '治療費')
    medicine_cost = Classification.create(name: '医薬品費')
    travel_cost = Classification.create(name: '交通費')

    expect(Classification.all).to match_array([treatment_cost, medicine_cost, travel_cost])
  end
end
