require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let!(:user) { create(:user) }
  let!(:child) { build(:child, user_id: user.id) }
  let!(:task) { build(:task, user_id: user.id) }
  let!(:reward) { build(:reward, user_id: user.id) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }

      it 'メニューを押すと、自分のユーザ詳細画面に遷移する' do
        about_link = find_all('a')[1].text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it 'マイページを押すと、自分のユーザ詳細画面に遷移する' do
        home_link = find_all('a')[2].text
        home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_link
        is_expected.to eq '/users/' + user.id.to_s
      end
      it 'おうちの方はこちらを押すと、保護者の管理画面に遷移する' do
        menu_link = find_all('a')[4].text
        menu_link = menu_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link menu_link
        is_expected.to eq '/menu'
      end
    end
  end

  describe 'Task一覧画面のテスト' do
    before do
      visit tasks_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/tasks'
      end
    end
  end

  #投稿、詳細、編集のテストを追加する

    describe 'Reward一覧画面のテスト' do
      before do
        visit rewards_path
      end

      context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/rewards'
      end
    end
  #投稿、詳細、編集のテストを追加する

  end
end
