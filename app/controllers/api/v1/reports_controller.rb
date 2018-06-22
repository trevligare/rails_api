# frozen_string_literal: true

module Api
  module V1
    class ReportsController < ApplicationController
      before_action :verify_create_params, only: :create

      def index
        statements = Statement.preload(:reporter)
                              .joins(:reporter)
                              .where('reporters.source_id': @source.id)

        render json: {
          classifications: Classification.all,
          source: @source,
          reporters: @source.reporter,
          statements: statements
        }, status: 200
      end

      def create
        reporter = Reporter.find_or_create_by(source: @source, uuid: @report[:uuid])
        statement = Statement.new(
          text: @report[:text],
          classification_id: @report[:classification_id],
          reporter: reporter
        )
        if statement.save!
          render json: { id: statement.id }, status: 201
        else
          error_code('Could not save statement', 422)
        end
      end

      private

      def verify_create_params
        c = params[:classification]
        return error_code('parameter "nice" no longer accepted') if params[:nice].present?
        return error_code('missing "reporter" parameter') if params[:reporter].blank?
        return error_code('missing "text" parameter') if params[:text].blank?
        return error_code('missing "classification" parameter') if c.blank?
        @classification = find_classification(c)
        return error_code('classifcation not registered') unless @classification
        @report = {
          text: params[:text],
          classification_id: @classification.id,
          uuid: params[:reporter]
        }
      end

      def find_classification(c)
        return Classification.find(c)
      rescue ActiveRecord::RecordNotFound
        return Classification.find_by(slug: c)
      end
    end
  end
end
