class CarCreator
  include Virtus.model

  extend  ActiveModel::Naming
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :user
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

  # Avoid matching purchase and production by adding 1 hour.
  def purchased_at=(purchased_at)
    @purchased_at = purchased_at + 1.hour
  end

  # Make sure that cyrilic chars are translated.
  def plate=(plate)
    plate = plate.mb_chars.upcase.to_s

    mapping = {
      'А' => 'A',
      'В' => 'B',
      'С' => 'C',
      'Е' => 'E',
      'Н' => 'H',
      'К' => 'K',
      'М' => 'M',
      'О' => 'O',
      'Р' => 'P',
      'Т' => 'T',
      'Х' => 'X',
      'У' => 'Y'
    }

    plate.each_char do |letter|
      if mapping[letter].present?
        plate.sub!(letter, mapping[letter])
      end
    end

    super plate
  end

  # Validations
  validates :plate, presence: true,
                    format: {
                      with: /(A|B|BH|BP|BT|E|EB|EH|K|KH|M|H|OB|P|PA|PB|PK|PP|C|CA|CB|CH|CM|CO|CC|CT|T|TX|Y|X){1}[0-9]{4}[0-9ABCEHKMOPTXY]{2}/,
                      message: I18n.t('activemodel.errors.models.car_creator.attributes.plate.invalid_format')
                    }

  validates :produced_at, presence: true
  validates :purchased_at, presence: true
  validates :mileage_at_purchase, presence: true,
                                  numericality: {
                                    only_integer: true,
                                    greater_than_or_equal_to: 0
                                  }

  validate :validate_production_date_cannot_be_in_the_future,
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

  def persist!
    @car                = Car.create!(plate: plate, make: make, model: model, vin: vin, engine_number: engine_number, user_id: user.id)
    @production_history = ProductionHistory.create!(mileage: 0, happened_at: produced_at, car_id: car.id)
    @purchase_history   = PurchaseHistory.create!(mileage: mileage_at_purchase, happened_at: purchased_at, car_id: car.id)
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
