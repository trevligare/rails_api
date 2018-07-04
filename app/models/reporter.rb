class Reporter < ApplicationRecord
  belongs_to :source
  has_many :statement
  has_many :classifications
end
