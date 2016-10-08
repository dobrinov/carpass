class Location < ActiveRecord::Base
  has_many :car_services

  validates :name,
            :address,
            :city,
            :latitude,
            :longitude,
            :zoom_level, presence: true
end
