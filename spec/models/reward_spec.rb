require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'バリデーションのテスト' do
    subject { reward.valid? }

    let(:user) { create(:user) }
    let!(:reward) { build(:reward, user_id: user.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        reward.name = ''
        is_expected.to eq false
      end
    end

    context 'pointカラム' do
      it '空欄でないこと' do
        reward.point = nil
        is_expected.to eq false
      end
    end
  end
end