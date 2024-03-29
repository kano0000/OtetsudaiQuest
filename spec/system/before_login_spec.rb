require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'Log inリンクが表示される: 青色のボタンの表示が「つづきから」である' do
        log_in_link = find('.btn-login').text
        expect(log_in_link).to match(/つづきから/)
      end

      it 'Sign upリンクが表示される: 緑色のボタンの表示が「あたらしくはじめる」である' do
        sign_up_link = find('.btn-signin').text
        expect(sign_up_link).to match(/あたらしくはじめる/)
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'ヘッダーが表示されないこと' do
        expect(page).not_to have_css('#navArea')
      end
      it 'ロゴが表示されないこと' do
        expect(page).not_to have_css('nav img[src*="logo.png"]')
      end
      it 'メニューリンクが表示されないこと' do
        expect(page).not_to have_link('メニュー', href: about_path)
      end
      it 'マイページリンクが表示されないこと' do
        expect(page).not_to have_link('マイページ')
      end
      it 'ログアウトリンクが表示されないこと' do
        expect(page).not_to have_link('ログアウト', href: destroy_user_session_path)
      end
      it 'おうちの方はこちらリンクが表示されないこと' do
        expect(page).not_to have_link('おうちの方はこちら', href: menu_path)
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end

      it '「とうろく」と表示される' do
        expect(page).to have_css('h1', text: 'とうろく')
      end

      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end

      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end

      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end

      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end

      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'とうろく'
      end

      it '「もどる」ボタンが表示される' do
        expect(page).to have_link('もどる', href: root_path)
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button 'とうろく' }.to change(User, :count).by(1)
      end

      it '新規登録後のリダイレクト先が、Aboutページになっている' do
        click_button 'とうろく'
        expect(current_path).to eq about_path
      end
    end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
      it 'nameフォームは表示されない' do
        expect(page).not_to have_field 'user[name]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先がAboutページになっている' do
        expect(current_path).to eq about_path
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it 'トップページへのリンクが表示される' do
        expect(page).to have_link('', href: root_path)
      end
      it 'メニューリンクが表示される' do
        expect(page).to have_link('', href: about_path)
      end
      it 'マイページへのリンクが表示される' do
        expect(page).to have_link('マイページ')
      end
      it 'ログアウトリンクが表示される' do
        expect(page).to have_link('ログアウト', href: destroy_user_session_path)
      end
      it 'おうちの方はこちらへのリンクが表示される' do
        expect(page).to have_link('おうちの方はこちら', href: menu_path)
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }
  
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      logout_link = find_all('a')[4].text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link 'ログアウト'
    end
  
    context 'ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end