# frozen_string_literal: true

class JWTHelper
  def self.valid_jwt
    load_from_file 'spec/fixtures/valid_auth0_jwt'
  end

  def self.invalid_jwt
    load_from_file 'spec/fixtures/invalid_auth0_jwt'
  end

  def self.valid_code
    load_from_file 'spec/fixtures/valid_auth0_code'
  end

  private_class_method

  def self.load_from_file(path)
    File.read(Rails.root.join(path)).chomp
  end
end
