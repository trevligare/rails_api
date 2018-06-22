# frozen_string_literal: true

class Statement < ApplicationRecord
  belongs_to :reporter
  belongs_to :classification
end
