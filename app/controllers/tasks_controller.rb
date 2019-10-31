class TasksController < ApplicationController
  before_action :edit_correct_user, only: :edit
  before_action :task_correct_user, only: [:new, :show, :index]

  
  def index
    @tasks = Task.where(user_id: @current_user.id).order(created_at: :desc)
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
      flash[:success] = "#{@task.name}を更新しました。"
      redirect_to user_task_path(@current_user.id, @task.id)
    else
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "#{@task.name}のデータを削除しました。"
    redirect_to user_tasks_path
  end
  
  private
  
    
    def task_params
      params.require(:user).permit(tasks: [:name, :note])[:tasks]
    end
    
    def task_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user)
        flash[:danger] = "アクセス権限がありません"
        redirect_to(root_url)
      end
    end
    
    def edit_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user)
        flash[:danger] = "編集権限がありません"
        redirect_to user_tasks_path(current_user)
      end
    end

      
end
