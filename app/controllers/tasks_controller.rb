class TasksController < ApplicationController

  
  def index
    @tasks = Task.all
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
  
  private
  
    
    def task_params
      params.require(:user).permit(tasks: [:name, :note])[:tasks]
    end
    
end
