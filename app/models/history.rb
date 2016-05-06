class History < ActiveRecord::Base
  belongs_to :car

  validates :mileage, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true

  validates :happened_at, presence: true

  validates :cost, numericality: { allow_blank: true, greater_than_or_equal_to: 0 }

  def notify_expiration
    # Do nothing
  end
end
