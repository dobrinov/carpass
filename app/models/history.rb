class History < ActiveRecord::Base
  belongs_to :car

  validates :mileage, presence: true,
                      numericality: { only_integer: true, greater_than: 0 }
  validates :created_at, presence: true
end
