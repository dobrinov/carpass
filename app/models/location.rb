class Location < ActiveRecord::Base
  enum category: [ :annual_inspection ]

  validates :name,
            :address,
            :city,
            :category,
            :latitude,
            :longitude,
            :zoom_level, presence: true
end
