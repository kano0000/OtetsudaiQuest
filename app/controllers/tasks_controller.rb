class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    # 実行できるものを前に出して並び替え
    if params[:latest]
     @tasks = current_user.tasks.order(status: :asc, created_at: :desc).page(params[:page]).per(9)
    elsif params[:most_point]
     @tasks = current_user.tasks.order(status: :asc, point: :desc).page(params[:page]).per(9)
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(9)
    end
  end

  def show
    @task = Task.find(params[:id])
    @children = current_user.children
    @task_new = Task.new
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    tags = Vision.get_image_data(task_params[:quest_image])
    if @task.save
      @tag_names = tags
      flash[:notice] = "登録しました"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "更新しました。"
      redirect_to task_path(@task)
    else
      render :show
    end
  end

  def admin_index
    if params[:not_finish]
      @tasks = current_user.tasks.where(status: "preparing").order(created_at: :desc).page(params[:page])
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
    end
  end

  def status_change
    @task = Task.find(params[:id])

    if @task.status == "preparing"
      if params[:start] == "true"
        @task.update(status: "in_progress")
      end
    elsif @task.status == "in_progress"
      @task.update(status: "reported_complete")
    elsif @task.status == "reported_complete"
      if params[:check] == 'OK'
      @task.update(status: "completed")
      else
        @task.update(status: "again")
      end
    elsif @task.status == "again"
      @task.update(status: "reported_complete")
    end
  end

  def thanks
    @task = Task.find(params[:id])
    @children = @task.children
  end
  # thanks_pageでリロードした際にポイントが加算されないようにする
  def thanks_view
    @task = Task.find(params[:id])
    @children = @task.children
    render 'tasks/thanks'
  end

  private

  def task_params
    params.require(:task).permit(:task_list_id, :description, :point, :num_people, :quest_image)
  end

end
