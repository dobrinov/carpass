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
                                  settlement: vehicle_inspection_company[:settlement],
                                  settlement_type: vehicle_inspection_company[:settlement_type],
                                  address: vehicle_inspection_company[:address],
                                  longitude: Bulgaria::LONGITUDE,
                                  latitude: Bulgaria::LATITUDE

          vehicle_inspection = VehicleInspection.new license: vehicle_inspection_company[:license]
          location.vehicle_inspections << vehicle_inspection

          location.save!
          vehicle_inspection.save!
        end
      end
    end
  end
end
