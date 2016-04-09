class History < ActiveRecord::Base
  belongs_to :car

  validates :mileage, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true

  validates :happened_at, presence: true

  validates :cost, numericality: { allow_blank: true, greater_than_or_equal_to: 0 }

  # validate :validate_mileage_value

  private

  # def validate_mileage_value
  #   if mileage && car.histories.last && mileage < car.histories.last.mileage
  #     errors.add(:mileage, I18n.t('activemodel.errors.models.history.attributes.mileage.lower_than_last_recorded'))
  #   end
  # end
end
