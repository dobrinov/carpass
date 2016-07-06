require 'rails_helper'

RSpec.describe HistoryExpirationNotifier do
  let(:user) { User.create! email: 'foo@example.com', password: 'qweqwe' }
  let(:car) { Car.create! plate: 'CA1111XX', user: user }
  let(:history_attributes) do
    {
      happened_at: Date.today - 30.days,
      valid_until: Date.today + 7.days,
      car: car
    }
  end

  let(:expiring_annual_inspection_history_notification) { double :expiring_annual_inspection_history_notification }
  let(:expiring_compulsory_insurance_history_notification) { double :expiring_compulsory_insurance_history_notification }
  let(:expiring_full_insurance_history_notification) { double :expiring_full_insurance_history_notification }

  before do
    AnnualInspectionHistory.create! history_attributes
    CompulsoryInsuranceHistory.create! history_attributes
    FullInsuranceHistory.create! history_attributes
    MaintenanceHistory.create! history_attributes
    RepairmentHistory.create! history_attributes
    TaxHistory.create! history_attributes
    TuningHistory.create! history_attributes
    TyreHistory.create! history_attributes
    VignetteHistory.create! history_attributes

    allow(ExpiringAnnualInspectionHistoryNotification).
      to receive(:create!).
      and_return(expiring_annual_inspection_history_notification)
    allow(ExpiringCompulsoryInsuranceHistoryNotification).
      to receive(:create!).
      and_return(expiring_compulsory_insurance_history_notification)
    allow(ExpiringFullInsuranceHistoryNotification).
      to receive(:create!).
      and_return(expiring_full_insurance_history_notification)
  end

  it 'delivers notifications' do
    expect(expiring_annual_inspection_history_notification).to receive(:deliver)
    expect(expiring_compulsory_insurance_history_notification).to receive(:deliver)
    expect(expiring_full_insurance_history_notification).to receive(:deliver)

    HistoryExpirationNotifier.call
  end
end
