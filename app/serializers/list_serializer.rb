# frozen_string_literal: true

class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :deadline
end
