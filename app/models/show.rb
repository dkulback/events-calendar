class Show < ApplicationRecord
  scope :by_date, lambda {
    where('date >= ?', Date.today).order(:date)
  }

  def self.search(search_params, date_params = nil)
    if date_params
      Show.where(['date = ? and venue ILIKE ?', date_params, "%#{search_params}%"])
    else
      by_date.where('venue ILIKE ?', "%#{search_params}%")
    end
  end
end
