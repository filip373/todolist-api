# frozen_string_literal: true

module Auth
  class AuthsController < ActionController::Base
    def login
      redirect_to GetAuthURL.new.call
    end

    def callback
      return render(plain: error_param) if error_param
      render plain: GetAccessToken.new(params[:code]).call
    end

    private

    def error_param
      params[:error]
    end
  end
end
