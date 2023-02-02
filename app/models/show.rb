class Show < ApplicationRecord
  scope :by_date, lambda {
    where('date >= ?', Date.today).order(:date)
  }

  def self.search(search_params)
    by_date.where('venue ILIKE ?', "%#{search_params}%")
  end
end
