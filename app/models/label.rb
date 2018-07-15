class Label < ApplicationRecord

  def self.fuzzy_find(labal_param)
    Label.find(labal_param)
  rescue ActiveRecord::RecordNotFound
    Label.find_by(slug: labal_param)
  end
end
