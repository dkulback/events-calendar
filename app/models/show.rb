class Show < ApplicationRecord
  def self.by_date
    order(:date)
  end
end
