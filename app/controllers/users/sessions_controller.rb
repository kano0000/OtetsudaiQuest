class Users::SessionsController < Devise::SessionsController
  
  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:notice] = "ゲストユーザーでログインしました。"
    redirect_to about_path
  end
  
end