# frozen_string_literal: true

class ListMailer < ApplicationMailer
  def new_list(id)
    list = List.find id
    @title = list.title
    mail subject: 'Your new list has just been created', to: list.user.email
  end
end
