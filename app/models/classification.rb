class Classification < ApplicationRecord
  belongs_to :label
  belongs_to :reporter
  belongs_to :statement
end
