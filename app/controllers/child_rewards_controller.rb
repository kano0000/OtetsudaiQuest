class ChildRewardsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    child = Child.find(params[:child_id])
    rewards = Reward.find(params[:reward_id])
    
    ChildRewards.create(child: @child, reward: @reward)

    
  end
end
