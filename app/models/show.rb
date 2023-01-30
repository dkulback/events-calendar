class Show < ApplicationRecord
  scope :by_date, lambda {
                    where(date: Date.today..Date.today.next_year).order(:date)
                  }
end
