class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:about]

  def top

  end

  def about

  end
end
