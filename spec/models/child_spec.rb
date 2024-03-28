require 'rails_helper'

RSpec.describe "Childモデルのテスト", type: :model do
  describe 'バリデーションのテスト' do
    subject { child.valid? }

    let(:user) { create(:user) }
    let!(:child) { build(:child, user_id: user.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        child.name = ''
        is_expected.to eq false
      end

      it '2文字以上であること' do
        child.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end

      it '20文字以下であること' do
        child.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end

      it '2文字未満であると無効であること' do
        child.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end

      it '20文字を超えると無効であること' do
        child.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'birth_atカラム' do
      it '空欄でないこと' do
        child.birth_at = nil
        is_expected.to eq false
      end
    end
  end
end