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
    if params[:latest]
      @rewards = current_user.rewards.order(created_at: :desc)
    elsif params[:most_point]
      @rewards = current_user.rewards.order(point: :desc)
    else
      @rewards = current_user.rewards
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

  def admin_index
    @rewards  = current_user.rewards
  end

  def exchange
    @reward = Reward.find(params[:id])
    @children = current_user.children
    selected_child_id = params[:reward][:child_id] if params[:reward].present?
    @child = Child.find_by(id: selected_child_id) if selected_child_id.present?
  end

  #def update_child_point
   # @child = Child.find(params[:id])
    #@reward = Reward.find(params[:id])
    #@child_reward = ChildReward.find_by(child: @child, reward: @reward)
    #redirect_to confirm_path
  #end

  def confirm
    child = Child.find(params[:child_id])  # child_id を使用するように修正
    reward = Reward.find(params[:reward_id])  # 実際のパラメータ名に合わせて修正
    new_point = child.point - reward.point
    child.update(point: new_point)
  end

  private

  def reward_params
    params.require(:reward).permit(:name, :description, :gift_image, :point, :published)
  end
end
