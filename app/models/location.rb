class Location < ActiveRecord::Base
  has_many :car_services, dependent: :destroy

  validates :name,
            :address,
            :city,
            :latitude,
            :longitude, presence: true
end
