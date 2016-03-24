class Car < ActiveRecord::Base
  belongs_to :user
  has_many :histories, dependent: :destroy

  def total_spent
    histories.sum(:cost)
  end
end
