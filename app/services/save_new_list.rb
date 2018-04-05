# frozen_string_literal: true

class SaveNewList
  def initialize(list)
    @list = list
  end

  def call
    if @list.save
      ListMailer.new_list(@list.id).deliver_later
      return true
    end
    false
  end
end
