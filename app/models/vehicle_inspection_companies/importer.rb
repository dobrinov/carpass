module VehicleInspectionCompanies
  class Importer
    def self.call
      new.call
    end

    def call
      Register.all.each do |vehicle_inspection_company|
        next if VehicleInspection.where(license: vehicle_inspection_company[:license]).any?


        ActiveRecord::Base.transaction do
          location = Location.new name: vehicle_inspection_company[:company],
                                  city: vehicle_inspection_company[:city],
                                  address: vehicle_inspection_company[:address],
                                  longitude: 0.0,
                                  latitude: 0.0

          vehicle_inspection = VehicleInspection.new license: vehicle_inspection_company[:license],
                                                     location_id: location.id

          location.save!
          vehicle_inspection.save!
        end
      end
    end
  end
end
