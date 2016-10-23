class GuestUser
  def self.create!
    user = generate_user
    car = generate_car

    compulsory_insurance = generate_compulsory_insurance_history

    car.histories << generate_production_history
    car.histories << generate_purchase_history
    car.histories << compulsory_insurance
    car.histories << generate_maintenance_history
    car.histories << generate_full_insurance_hisotry
    car.histories << generate_annual_inspection_history
    car.histories << generate_tuning_history
    car.histories << generate_tyre_history
    car.histories << generate_repairment_history

    user.notifications << generate_expiring_compulsory_insurance_notification(compulsory_insurance)

    user.cars << car

    user.save!

    user
  end

  def self.generate_user
    User.new do |u|
      u.email = generate_email
      u.password = 'guestuser'
      u.password_confirmation = 'guestuser'
      u.first_name = 'Демо'
      u.last_name = 'Потребител'
      u.guest = true

      u.build_setting
    end
  end

  def self.generate_car
    Car.new do |c|
      c.plate = 'CA0001XX'
      c.brand = Brand.where(name: 'Toyota').first
      c.model = 'Corolla'
      c.vin = 'ABCD1234'
      c.engine_number = '123456789'
    end
  end

  def self.generate_production_history
    ProductionHistory.new mileage: 0, happened_at: Date.today - 8.years
  end

  def self.generate_purchase_history
    PurchaseHistory.new mileage: 96_000, happened_at: Date.today - (1.year + 6.months)
  end

  def self.generate_maintenance_history
    MaintenanceHistory.new \
      mileage: 96_500,
      happened_at: Date.today - (1.year - 1.week),
      cost: 500,
      details: <<-HTML
      * Сменен ангренажен ремък</br>
      * Сменено масло (Castrol 5W40)</br>
      * Сменен маслен филтър</br>
      * Сменен въздушен филтър</br>
      * Сменен горивен филтър
      HTML
  end

  def self.generate_full_insurance_hisotry
    FullInsuranceHistory.new \
      mileage: 96_900,
      happened_at: Date.today - (1.year - 2.weeks),
      valid_until: Date.today - (1.year - 2.weeks) + 3.months,
      cost: 263,
      details: <<-HTML
        1/4 вноска в Застраховки ООД
      HTML
  end

  def self.generate_compulsory_insurance_history
    CompulsoryInsuranceHistory.new \
      mileage: 96_001,
      happened_at: Date.today - 1.year,
      valid_until: Date.today - (1.year - 3.months),
      cost: 190,
      details: <<-HTML
        Платена наведнъж в Застраховки ООД
      HTML
  end

  def self.generate_annual_inspection_history
    AnnualInspectionHistory.new \
      mileage: 102_300,
      happened_at: Date.today - (1.year - 4.months),
      valid_until: Date.today + 4.months,
      cost: 40,
      details: 'Всичко е изрядно'
  end

  def self.generate_tuning_history
    TuningHistory.new \
      mileage: 99_000,
      happened_at: Date.today - (1.year - 6.weeks),
      cost: 550,
      details: 'Лети джанти 16"'
  end

  def self.generate_tyre_history
    TyreHistory.new \
      mileage: 100_000,
      happened_at: Date.today - (1.year - 2.months),
      cost: 600,
      details: 'Четири гуми 205/55/16 Yokohama'
  end

  def self.generate_repairment_history
    RepairmentHistory.new \
      mileage: 112_200,
      happened_at: Date.today - 1.month,
      cost: 200,
      details: 'Смяна на предни дискове'
  end

  def self.generate_expiring_compulsory_insurance_notification(expiring_compulsory_insurance)
    ExpiringCompulsoryInsuranceHistoryNotification.new \
      notifiable: expiring_compulsory_insurance
  end

  def self.generate_email
    "#{SecureRandom.hex}@carpass.bg"
  end
end
