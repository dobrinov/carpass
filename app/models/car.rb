class Car < ActiveRecord::Base
  belongs_to :user
  has_many :histories, dependent: :destroy

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
end
