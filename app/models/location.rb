class Location < ActiveRecord::Base
  has_many :vehicle_inspections, dependent: :destroy

  validates :name,
            :address,
            :settlement,
            :settlement_type,
            :latitude,
            :longitude, presence: true

  enum settlement_type: [:unknown, :city, :village]

  scope :with_defined_geolocation, -> { where.not('latitude = ? OR longitude = ?', Bulgaria::LATITUDE, Bulgaria::LONGITUDE) }
  scope :with_default_geolocation, -> { where('latitude = ? AND longitude = ?', Bulgaria::LATITUDE, Bulgaria::LONGITUDE) }
end