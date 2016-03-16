class CarCreator
  include Virtus.model

  extend  ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :user
  attr_reader :car
  attr_reader :production_history
  attr_reader :purchase_history

  # Attributes
  attribute :user,                User
  attribute :plate,               String
  attribute :vin,                 String
  attribute :engine_number,       String
  attribute :produced_at,         DateTime
  attribute :purchased_at,        DateTime
  attribute :mileage_at_purchase, Integer

  # Validations
  validates :plate, presence: true
  validates :produced_at, presence: true
  validates :purchased_at, presence: true
  validates :mileage_at_purchase, presence: true

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

  def persist!
    @car                = Car.create!(plate: plate, vin: vin, engine_number: engine_number, user_id: user.id)
    @production_history = DateOfProduction.create!(created_at: produced_at, car_id: car.id)
    @purchase_history   = DateOfPurchase.create!(mileage: mileage_at_purchase, created_at: purchased_at, car_id: car.id)
  end
end
