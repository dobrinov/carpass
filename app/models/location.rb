class Location < ActiveRecord::Base
  has_many :car_services, dependent: :destroy

  validates :name,
            :address,
            :settlement,
            :settlement_type,
            :latitude,
            :longitude, presence: true

  enum settlement_type: [:unknown, :city, :village]
end
