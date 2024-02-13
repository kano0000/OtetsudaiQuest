class ChildrenController < ApplicationController
  before_action :authenticate_user!

  def new
    @child = Child.new
  end

  def create
    @child = Child.new(child_params)
    @child.user_id = current_user.id
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
    # TODO: Date.current.in_time_zone('Asia/Tokyo').all_month
    @month_clear = @child.tasks.where(status: "completed").where(updated_at: Date.current.all_month).count
    @level = @child.level(@month_clear)
  end

  def edit
    @child = Child.find(params[:id])
  end

  def update
    @child = Child.find(params[:id])
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

private

  def child_params
    params.require(:child).permit(:name, :birth_at, :introduction, :profile_image, :favorite_food, :future_dream)
  end
end
