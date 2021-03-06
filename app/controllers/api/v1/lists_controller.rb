# frozen_string_literal: true

module API
  module V1
    class ListsController < APIV1Controller
      before_action :set_list, only: %i[show update destroy]
      rescue_from ActiveRecord::RecordNotFound, with: :respond_not_found

      # GET /lists
      def index
        @lists = List.all

        render json: @lists
      end

      # GET /lists/1
      def show
        render json: @list
      end

      # POST /lists
      def create
        @list = InitializeList.new(params: list_params, user: current_user).call
        if SaveNewList.new(@list).call
          render json: @list,
                 status: :created,
                 location: api_v1_list_path(@list)
        else
          render_errors
        end
      end

      # PATCH/PUT /lists/1
      def update
        if @list.update list_params
          render json: @list
        else
          render_errors
        end
      end

      # DELETE /lists/1
      def destroy
        @list.destroy
      end

      private

      def set_list
        @list = List.find params[:id]
      end

      def list_params
        params.require(:list).permit :title, :deadline
      end

      def render_errors
        render json: @list.errors, status: :unprocessable_entity
      end
    end
  end
end
