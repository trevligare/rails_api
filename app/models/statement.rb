# frozen_string_literal: true

class Statement < ApplicationRecord
  belongs_to :reporter
  has_many :classifications

  def classify(reporter, label)
    Classification.find_or_create_by!(
      statement_id: id,
      reporter_id: reporter.id,
      label_id: label.id
    ) if label.present? && reporter.present?
  end
end
