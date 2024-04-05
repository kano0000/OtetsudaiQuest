class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
    @children = current_user.children
    @child = Child.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if user_params[:profile_image].present?
      profile_image_safety = Vision.get_image_data(user_params[:profile_image])
      
      unless profile_image_safety
        # :base は、Railsでモデルにエラーメッセージを追加する際に使用される特別なシンボル。
        @user.errors.add(:base, '画像が不適切です。')
        render :edit
        return
      end
    end
    
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "更新しました。"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
