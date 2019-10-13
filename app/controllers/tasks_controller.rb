class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @user = User.find(session[:user_id])
    @task = Task.new(
      name: params[:name],
      note: params[:note],
      user_id: @user.id,
      )
    if @task.save
      redirect_to tasks_index_url
    else
      render :new
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  private
  
    def task_params
      params.require(:task).permit(:name, :note)
    end
    
end
