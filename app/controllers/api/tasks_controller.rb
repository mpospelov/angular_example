module Api
  class TasksController < BaseController
    before_action :authenticate_user!

    def index
      tasks = current_user.tasks
      render_object TaskPresenter.for_collection.new(tasks)
    end

    def destroy
      current_user.tasks.find(params[:id]).destroy
      render json: { message: "Task successfully deleted!" }
    end

    def create
      task = current_user.tasks.build(task_params)
      if task.save
        render_object TaskPresenter.new(task)
      else
        render_errors task
      end
    end

    def update
      task = current_user.tasks.find(params[:id])
      if task.update(task_params)
        render_object TaskPresenter.new(task)
      else
        render_errors task
      end
    end

    private

    def task_params
      params.permit(:description, :date, :duration)
    end
  end
end
