# frozen_string_literal: true

module Api
  module V1
    class ReportsController < ApplicationController
      before_action :verify_create_params, only: :create

      def index
        statements = Statement.preload(:reporter)
                              .joins(:reporter)
                              .where('reporters.source_id': @source.id)

        classifications = Classification.preload(:reporter)
                                        .joins(:reporter)
                                        .where('reporters.source_id': @source.id)

        render json: {
          labels: Label.all,
          classifications: classifications,
          source: @source,
          reporters: @source.reporters,
          statements: statements
        }, status: 200
      end

      def create
        report = Report.create(@report_params)
        if report
          render json: { id: report[:statement_id] }, status: 201
        else
          error_code('Could not save', 422)
        end
      end

      private

      def verify_create_params
        return error_code('parameter "nice" no longer accepted') if params[:nice].present?
        return error_code('missing "reporter" parameter') if params[:reporter].blank?
        return error_code('missing "text" parameter') if params[:text].blank?

        label_param = params[:label]
        return error_code('missing "label" parameter') if label_param.blank?
        label = find_label(label_param)
        return error_code('classifcation not registered') unless label

        @report_params = {
          statement_text: params[:text],
          label_id: label.id,
          reporter_uuid: params[:reporter],
          source_id: @source.id
        }
      end

      def find_label(labal_param)
        Label.find(labal_param)
      rescue ActiveRecord::RecordNotFound
        Label.find_by(slug: labal_param)
      end
    end
  end
end
