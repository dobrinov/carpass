class History < ActiveRecord::Base
  belongs_to :car

  validates :mileage,    presence: true
  validates :created_at, presence: true
end
