# frozen_string_literal: true

module Api
  module V1
    class ClassificationsController < ApplicationController
      before_action :verify_create_params, only: :create

      def create
        classification = @statement.classify(@reporter, @label)
        if classification
          render json: { id: classification.id }, status: 201
        else
          error_code('Could not save', 422)
        end
      end

      private

      def verify_create_params
        return error_code('missing "reporter" parameter') if params[:reporter].blank?
        @reporter = Reporter.find_or_create_by(
          source_id: @source.id,
          uuid: params[:reporter]
        )

        return error_code('missing "label" parameter') if params[:label].blank?
        @label = Label.fuzzy_find(params[:label])
        return error_code('label not previously registered') unless @label

        return error_code('missing "statement" parameter') if params[:statement].blank?
        @statement = Statement.find(params[:statement])
        return error_code('statement not previously registered') unless @statement

      end
    end
  end
end
