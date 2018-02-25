# frozen_string_literal: true

module Auth
  class AuthsController < ActionController::Base
    def login
      redirect_to GetAuthURL.new.call
    end

    def callback
      return render(plain: params[:error]) if params[:error]
      render plain: GetAccessToken.new(params[:code]).call
    end
  end
end
