class ChildrenController < ApplicationController
  
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

private

  def child_params
    params.require(:child).permit(:name, :birth_at, :introduction, :profile_image)
  end
end
