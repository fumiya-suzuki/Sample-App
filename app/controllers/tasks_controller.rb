class TasksController < ApplicationController

  
  def index
    @tasks = Task.where(user_id: @current_user.id)

  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(
      name: params[:name],
      note: params[:note],
      user_id: @current_user.id,
      )
    if @task.save 
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_path
    else
      render :new
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    @task.name = params[:name]
    @task.note = params[:note]
    if @task.save
      flash[:success] = "taskを更新しました。"
      redirect_to user_tasks_path
    else
      render :new
    end
  end
  private
  
    
    def task_params
      params.require(:user).permit(tasks: [:name, :note])[:tasks]
    end
    
end
