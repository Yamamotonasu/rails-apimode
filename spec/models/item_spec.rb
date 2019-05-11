require 'rails_helper'

RSpec.describe Item, type: :model do
  # itemレコードはただひとつのtodoレコードに属する
  it { should belong_to(:todo) }
  # 保存前にnameカラムが存在する
  it { should validate_presence_of(:name) }
end
