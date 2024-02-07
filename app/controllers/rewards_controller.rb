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
    @rewards = current_user.rewards
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
  end
  
  def update_child_point
    @child = Child.find(params[:child_id])
    @reward = Reward.find(params[:id])
    @child_reward = ChildReward.find_by(child: @child, reward: @reward)

    @child.point -= @reward.point
    @child.save
  end 
  
  private

  def reward_params
    params.require(:reward).permit(:name, :description, :gift_image, :point, :published)
  end
end
