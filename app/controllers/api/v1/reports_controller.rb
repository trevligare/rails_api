# frozen_string_literal: true

module Api
  module V1
    class ReportsController < ApplicationController
      before_action :verify_create_params, only: :create
      def create
        statement = Statement.new(@create_params)
        if statement.save!
          render json: { id: statement.id }
        else
          error_code('Could not save statement', 422)
        end
      end

      private

      def verify_create_params
        return error_code('missing text parameter') if params[:text].blank?
        return error_code('missing nice parameter') if params[:nice].blank?
        return error_code('malformed nice parameter') unless params[:nice].match(/\A[1|0]\z/)
        @create_params = { text: params[:text], nice: params[:nice] }
      end

      def error_code(message, code = 400)
        return render json: { error: message }, status: code
      end
    end
  end
end
