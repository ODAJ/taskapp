class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).order(deadline: :asc).page(params[:page]).per(10)
  end

  def show
    # @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))
    
    if params[:back].present?
      render :new
      return
    end

    if @task.save
      redirect_to @task,notice: "タスク 「#{@task.name}」を登録しました。"
    else 
      render :new
    end
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to task_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    # head :no_content
  end

  

  private

  # strong parameters
  def task_params
    params.require(:task).permit(:name, :description, :image, :completed, :deadline)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
