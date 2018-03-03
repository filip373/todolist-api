# frozen_string_literal: true

SwaggerUiEngine.configure do |config|
  config.swagger_url = {
    v1: '/doc/v1/swagger.yaml'
  }
  config.admin_username = Settings.admin.username
  config.admin_password = Settings.admin.password
end
