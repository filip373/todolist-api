# frozen_string_literal: true

module API
  module V1
    class APIV1Controller < ActionController::API
      before_action :authenticate_user!
      rescue_from Unauthorized, with: :respond_not_found

      protected

      def respond_not_found
        render json: { error: 'Not Found' }, status: :not_found
      end

      private

      def authenticate_user!
        unless GetUserFromJWT.new(DecodeJWT.new(raw_token).call).call
          raise Unauthorized
        end
      rescue DecodeJWTError
        raise Unauthorized
      end

      def raw_token
        request.headers['authorization']&.split&.second
      end
    end
  end
end
