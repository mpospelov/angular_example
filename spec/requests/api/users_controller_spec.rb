require 'rails_helper'

RSpec.describe Api::UsersController do
  let(:user) { create :user }
  let(:json_response) { JSON.parse(response.body) }
  let(:token) { user.create_new_auth_token }
  let(:user_params) { attributes_for(:user) }
  describe "PATCH /api/user" do
    it "should return 401 error if no current user" do
      patch "/api/user"
      expect(response.status).to eq(401)
    end

    it "should update current user" do
      expect do
        patch "/api/user", token.merge(user_params)
        user.reload
      end.to change { user.attributes }
    end
  end
end
