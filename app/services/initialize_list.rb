# frozen_string_literal: true

class InitializeList
  def initialize(params:, user:)
    @params = params
    @user = user
  end

  def call
    list = List.new @params
    list.user = @user
    list
  end
end
