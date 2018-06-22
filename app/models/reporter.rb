class Reporter < ApplicationRecord
  belongs_to :source
  has_many :statement
end
