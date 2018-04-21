# frozen_string_literal: true

module Api
  module V1
    class ReportsController < ApplicationController
      before_action :verify_create_params, only: :create
      def create
        reporter = Reporter.find_or_create_by(source: @source, uuid: @report[:uuid])
        statement = Statement.new(text: @report[:text], nice: @report[:nice], reporter: reporter)
        if statement.save!
          render json: { id: statement.id }, status: 201
        else
          error_code('Could not save statement', 422)
        end
      end

      private

      def verify_create_params
        return error_code('missing reporter parameter') if params[:reporter].blank?
        return error_code('missing text parameter') if params[:text].blank?
        return error_code('missing nice parameter') if params[:nice].blank?
        return error_code('malformed nice parameter') unless params[:nice].match(/\A[1|0]\z/)
        @report = {
          text: params[:text],
          nice: params[:nice],
          uuid: params[:reporter]
        }
      end
    end
  end
end
