class Car < ActiveRecord::Base
  belongs_to :user
  has_many :histories, dependent: :destroy

  private

  def validate_production_history
    # can have only 1 production history
  end

  def validate_purchase_history
    # can have only 1 purchase history
  end
end
