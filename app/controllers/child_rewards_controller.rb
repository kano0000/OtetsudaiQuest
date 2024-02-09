class ChildRewardsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    child = Child.find(params[:child_id])
    reward = current_user.child_rewards.new(child_id: child.id)
    reward.save    
    redirect_to request.referer
  end
end
