class Location < ActiveRecord::Base
  enum category: [ :annual_inspection ]
end
