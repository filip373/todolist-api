# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/list
class ListPreview < ActionMailer::Preview
  def new_list
    ListMailer.new_list List.first.id
  end
end
