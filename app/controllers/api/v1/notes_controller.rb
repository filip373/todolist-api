# frozen_string_literal: true

module API
  module V1
    class NotesController < APIV1Controller
      before_action :set_note, only: %i[show update destroy]
      rescue_from ActiveRecord::RecordNotFound, with: :respond_not_found

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
          render json: @note,
                 status: :created,
                 location: api_v1_note_path(@note)
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
        params.require(:note).permit :title, :content, :list_id
      end
    end
  end
end
