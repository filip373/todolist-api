# frozen_string_literal: true

module API
  module V1
    class APIV1Controller < ActionController::API
      before_action :authenticate_user!
      rescue_from Unauthorized, with: :respond_not_found

      private

      def respond_not_found
        render json: { error: 'Not Found' }, status: :not_found
      end

      def authenticate_user!
        raise Unauthorized unless current_user
      end

      def current_user
        return @current_user if defined? @current_user
        @current_user = GetUserFromJWT.new(DecodeJWT.new(raw_token).call).call
      rescue DecodeJWTError
        @current_user = nil
      end

      def raw_token
        request.headers['authorization']&.split&.second
      end
    end
  end
end
