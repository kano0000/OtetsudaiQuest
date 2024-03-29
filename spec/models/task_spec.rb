require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    subject { task.valid? }

    let(:user) { create(:user) }
    let!(:task) { build(:task, user_id: user.id) }

    context 'num_peopleカラム' do
      it '空欄でないこと' do
        task.num_people = nil
        is_expected.to eq false
      end
    end

    context 'pointカラム' do
      it '空欄でないこと' do
        task.point = nil
        is_expected.to eq false
      end
    end
  end
end