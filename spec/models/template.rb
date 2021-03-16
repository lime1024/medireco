require 'rails_helper'

RSpec.describe Template do
  it 'テンプレートに名前があること' do
    tempate = Template.create(name: 'おさかな病院のテンプレート')

    expect(tempate.name).to eq 'おさかな病院のテンプレート'
  end
end
