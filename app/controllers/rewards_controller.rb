class RewardsController < ApplicationController
  before_action :authenticate_user!

  def new
    @is_parent = params[:is_parent]
    @reward = Reward.new
  end

  def create
    @reward = Reward.new(reward_params)
    @reward.user_id = current_user.id
    if @reward.save
      flash[:notice] = "登録しました"
      redirect_to reward_path(@reward)
    else
      render :new
    end

  end

  def index
    # 公開されているものを前に出して並び替え
    if params[:latest]
      @rewards = current_user.rewards.order(published: :desc, created_at: :desc).page(params[:page]).per(9)
    elsif params[:most_point]
      @rewards = current_user.rewards.order(published: :desc, point: :desc).page(params[:page]).per(9)
    else
      @rewards = current_user.rewards.order(created_at: :desc).page(params[:page])
    end
  end

  def show
    @reward = Reward.find(params[:id])
  end

  def edit
    @reward = Reward.find(params[:id])
  end

  def update
    @reward = Reward.find(params[:id])
    if @reward.update(reward_params)
      redirect_to reward_path(@reward)
      flash[:notice] = "更新しました。"
    else
      render :edit
    end
  end

  def destroy
    reward = Reward.find(params[:id])
    reward.destroy
    redirect_to rewards_admin_index_path(id: current_user.id)
  end

  def admin_index
    @rewards = current_user.rewards.page(params[:page])
  end

  def exchange
    @reward = Reward.find(params[:id])
    @children = current_user.children
    selected_child_id = params[:reward][:child_id] if params[:reward].present?
    @child = Child.find(selected_child_id) if selected_child_id.present?
  end

  def update_child_point
    @child = Child.find(params[:child_id])
    @reward = Reward.find(params[:id])
    #@child_reward = ChildReward.find_by(child: @child, reward: @reward)
    ChildReward.create(child: @child, reward: @reward)
    redirect_to complete_path(child_id: @child)
  end

  def complete
    @child = Child.find(params[:child_id])
    @reward = Reward.find(params[:id])
    month_clear = @child.tasks.where(status: "completed").where(updated_at: Date.current.all_month).count
    @level = @child.level(month_clear)
  end

  def order
    @child_rewards = current_user.child_rewards.order(created_at: :desc).page(params[:page])
    unread_notifications = current_user.notifications.where(read: false)
    unread_notifications.update_all(read: true)
  end

  def order_update
    @child_reward = current_user.child_rewards.find(params[:child_reward_id])
    @child_reward.update(presented_date: presented_date_params[:presented_date])
    redirect_to order_path
  end

  private

  def reward_params
    params.require(:reward).permit(:name, :description, :gift_image, :point, :published)
  end

  def presented_date_params
    params.require(:child_reward).permit(:presented_date)
  end
end
