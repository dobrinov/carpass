class Car < ActiveRecord::Base
  belongs_to :user
  belongs_to :brand

  has_many :histories, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  # Validations
  validates :plate, presence: true,
                    format: {
                      with: /\A(A|B|BH|BP|BT|E|EB|EH|K|KH|M|H|OB|P|PA|PB|PK|PP|C|CA|CB|CH|CM|CO|CC|CT|T|TX|Y|X){1}[0-9]{4}[0-9ABCEHKMOPTXY]{1,2}\z/,
                      message: I18n.t('activemodel.errors.models.car_creator.attributes.plate.invalid_format')
                    }

  # Make sure that cyrilic chars are translated.
  def plate=(plate)
    super translate_plate(plate)
  end

  def total_spent
    histories.sum(:cost)
  end

  def current_mileage
    history = histories.where('mileage IS NOT NULL').order(mileage: :desc).first

    if history.present?
      history.mileage
    else
      0
    end
  end

  private

  def translate_plate(plate)
    return unless plate

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

    plate
  end
end
