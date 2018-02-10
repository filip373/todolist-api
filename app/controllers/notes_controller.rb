# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: %i[show update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  # GET /notes
  def index
    @notes = Note.all

    render json: @notes
  end

  # GET /notes/1
  def show
    render json: @note
  end

  # POST /notes
  def create
    @note = Note.new note_params

    if @note.save
      render json: @note, status: :created, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update note_params
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
  end

  private

  def set_note
    @note = Note.find params[:id]
  end

  def note_params
    params.require(:note).permit :title, :content
  end

  def render_not_found(error)
    render json: { error: error.message }, status: :not_found
  end
end
