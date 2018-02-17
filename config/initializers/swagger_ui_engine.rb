# frozen_string_literal: true

SwaggerUiEngine.configure do |config|
  config.swagger_url = {
    v1: '/doc/v1/swagger.yaml'
  }
  config.admin_username = ENV['ADMIN_USERNAME']
  config.admin_password = ENV['ADMIN_PASSWORD']
end
