require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Userモデルバリデーションのテスト' do
    subject { user.valid? }

    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end

      it '2文字以上であること' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end

      it '20文字以下であること' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      
      it '2文字未満であると無効であること' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end

      it '20文字を超えると無効であること' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
  end
  
end