require 'rails_helper'

RSpec.describe Todo, type: :model do
  # TodoモデルがItemモデルと1対多の関係であること
  it { should have_many(:items).dependent(:destroy) }
  # 保存前にタイトルカラムが存在する
  it { should validate_presence_of(:title) }
  # 保存前にcreated_byカラムが存在する
  it { should validate_presence_of(:created_by) }
end
