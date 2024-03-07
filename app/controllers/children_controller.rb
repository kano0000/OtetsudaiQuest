class ChildrenController < ApplicationController
  before_action :authenticate_user!

  def new
    @child = Child.new
  end

  def create
    @child = Child.new(child_params)
    @child.user_id = current_user.id
    
    if child_params[:profile_image].present? # 画像があれば処理
      profile_image_safety = Vision.get_image_data(child_params[:profile_image])
      
      unless profile_image_safety
        @child.errors.add(:base, 'ほかのしゃしんにかえてね！')
        render :new
        return
      end
    end

    if @child.save
      flash[:notice] = "登録しました"
      redirect_to child_path(@child)
    else
      render :new
    end
  end

  def show
    @child = Child.find(params[:id])
    @total_clear = @child.tasks.where(status: "completed").count
    @month_clear = @child.tasks.where(status: "completed").where(updated_at: Date.current.all_month).count
    @level = @child.level(@month_clear)
  end

  def edit
    @child = Child.find(params[:id])
  end

  def update
    @child = Child.find(params[:id])
    
    if child_params[:profile_image].present?
      profile_image_safety = Vision.get_image_data(child_params[:profile_image])
  
      unless profile_image_safety
        @child.errors.add(:base, 'ほかのしゃしんにかえてね！')
        render :edit
        return
      end
    end
    
    if @child.update(child_params)
      redirect_to child_path(@child)
      flash[:notice] = "更新しました。"
    else
      render :edit
    end
  end

  def clear_tasks
    @child = Child.find(params[:id])
    @tasks = @child.tasks.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def order_lists
    @child = Child.find(params[:id])
    @child_rewards = current_user.child_rewards.where(child_id: @child.id).order(created_at: :desc).page(params[:page]).per(10)
  end

private

  def child_params
    params.require(:child).permit(:name, :birth_at, :introduction, :profile_image, :favorite_food, :future_dream)
  end
end
