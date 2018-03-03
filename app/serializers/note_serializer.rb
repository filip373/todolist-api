# frozen_string_literal: true

class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :list_id
end
