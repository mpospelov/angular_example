require 'rails_helper'

RSpec.describe "Api::TasksController requests", type: :request do
  let(:user) { create :user }
  let(:json_response) { JSON.parse(response.body) }
  let(:token) { user.create_new_auth_token }

  describe "GET /api/tasks" do
    it "should return 401 error if no current user" do
      get "/api/tasks"
      expect(response.status).to eq(401)
    end

    it "should return all current user tasks" do
      tasks = create_list :task, 10, user: user
      create_list :task, 3

      get "/api/tasks", token

      expect(response.status).to eq(200)
      json_task_ids = json_response.map { |t| t["id"] }
      expect(json_task_ids).to eq(tasks.map(&:id))
    end
  end

  describe "DELETE /api/tasks/:id" do
    let(:task) { create :task, user: user }
    let(:non_user_task) { create :task }

    it "should return 401 error if no current user" do
      delete "/api/tasks/#{task.id}"
      expect(response.status).to eq(401)
    end

    it "should return 404 error if current user is not owner" do
      expect do
        delete "/api/tasks/#{non_user_task.id}", token
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should update task" do
      task
      expect do
        delete "/api/tasks/#{task.id}", token
        user.reload
      end.to change { user.tasks.count }.by(-1)
    end
  end

  describe "POST /api/tasks" do
    let(:task_params) { attributes_for :task }

    it "should return 401 error if no current user" do
      post "/api/tasks", task_params
      expect(response.status).to eq(401)
    end

    it "should update task" do
      expect do
        post "/api/tasks", token.merge(task_params)
        user.reload
      end.to change { user.tasks.count }
    end
  end

  describe "PATCH /api/tasks/:id" do
    let(:task) { create :task, user: user }
    let(:non_user_task) { create :task }
    let(:task_params) { attributes_for :task }

    it "should return 401 error if no current user" do
      patch "/api/tasks/#{task.id}", task_params
      expect(response.status).to eq(401)
    end

    it "should return 404 error if current user is not owner" do
      expect do
        patch "/api/tasks/#{non_user_task.id}", token
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should update task" do
      expect do
        patch "/api/tasks/#{task.id}", token.merge(task_params)
        task.reload
      end.to change { task.attributes }
    end
  end
end
