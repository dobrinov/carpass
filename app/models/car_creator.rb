class CarCreator
  include Virtus.model

  extend  ActiveModel::Naming
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :car
  attr_reader :production_history
  attr_reader :purchase_history

  # Attributes
  attribute :user,                User
  attribute :plate,               String
  attribute :make,                String
  attribute :model,               String
  attribute :vin,                 String
  attribute :engine_number,       String
  attribute :produced_at,         DateTime
  attribute :purchased_at,        DateTime
  attribute :mileage_at_purchase, Integer

  def initialize(*args, &block)
    super

    build_car
    build_production_history
    build_purchase_history
  end

  # Avoid matching purchase and production by adding 1 hour.
  def purchased_at=(purchased_at)
    @purchased_at = purchased_at + 1.hour
  end

  validates :produced_at, presence: true
  validates :purchased_at, presence: true
  validates :mileage_at_purchase, presence: true,
                                  numericality: {
                                    only_integer: true,
                                    greater_than_or_equal_to: 0
                                  }

  validate :validate_plate,
           :validate_production_date_cannot_be_in_the_future,
           :validate_purchase_date_cannot_be_in_the_future,
           :validate_production_date_cannot_after_the_purchase_date

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def build_car
    @car = Car.new(plate: plate, make: make, model: model, vin: vin, engine_number: engine_number, user: user)
  end

  def build_production_history
    @production_history = ProductionHistory.new(mileage: 0, happened_at: produced_at, car: car)
  end

  def build_purchase_history
    @purchase_history = PurchaseHistory.new(mileage: mileage_at_purchase, happened_at: purchased_at, car: car)
  end

  def persist!
    car.save!
    production_history.save!
    purchase_history.save!
  end

  def validate_plate
    unless car.valid?
      errors.add(:plate, car.errors[:plate])
    end
  end

  def validate_production_date_cannot_be_in_the_future
    if produced_at.present? && produced_at > Date.tomorrow - 1.second
      errors.add(:produced_at, I18n.t('activemodel.errors.models.car_creator.attributes.produced_at.in_the_future'))
    end
  end

  def validate_purchase_date_cannot_be_in_the_future
    if purchased_at.present? && purchased_at > Date.tomorrow - 1.second
      errors.add(:purchased_at, I18n.t('activemodel.errors.models.car_creator.attributes.purchased_at.in_the_future'))
    end
  end

  def validate_production_date_cannot_after_the_purchase_date
    if produced_at.present? && purchased_at.present? && purchased_at < produced_at
      errors.add(:purchased_at, I18n.t('activemodel.errors.models.car_creator.attributes.purchased_at.before_production'))
    end
  end
end
