class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(expired_at: :desc).page(params[:page]).per(5)
    elsif
      @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(5)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :asc).page(params[:page]).per(5)
    end
    if params[:title].present? && params[:status].present?
      @tasks = Task.search_title(params[:title]).search_status(params[:status])
    elsif params[:title].present?
      @tasks = Task.search_title(params[:title]).page(params[:page]).per(5)
    elsif params[:status].present?
      @tasks = Task.search_status(params[:status]).page(params[:page]).per(5)
    elsif params[:priority].present?
      @tasks = Task.priority_sort(params[:priority]).page(params[:page]).per(5)
    elsif params[:expired].present?
      @tasks = Task.expired_sort(params[:expired]).page(params[:page]).per(5)
    else
      @tasks = Task.all.page(params[:page]).per(5)
    end


  end
  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
    end

end
