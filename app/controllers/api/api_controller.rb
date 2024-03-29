module Api
  class ApiController < ApplicationController

    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token, if: :json_request?

    skip_before_filter :authenticate_user!

    acts_as_token_authentication_handler_for User, fallback_to_devise: false
    before_action :require_authentication

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    private

    def respond_with_failure(errors, status: :unprocessable_entity)
      render json: {errors: errors, messages: errors.full_messages}, status: status
    end

    def json_request?
      request.format.json?
    end

    def require_authentication
      throw(:warden, scope: :user) unless current_user.presence
    end

    def record_not_found(exception)
      render json: {errors: exception.message}, status: :not_found
    end
  end
end
