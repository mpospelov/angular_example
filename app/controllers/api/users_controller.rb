module Api
  class UsersController < BaseController
    before_action :authenticate_user!

    def update
      if current_user.update(user_params)
        render_object UserPresenter.new(current_user)
      else
        render json: { message: "Can't update user" }
      end
    end

    def user_params
      params.permit(:preferred_working_hours_per_day)
    end
  end
end
