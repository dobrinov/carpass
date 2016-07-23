require 'rails_helper'

RSpec.describe UnfinishedRegistrationsNotifier do
  let(:period) { 2.months }

  let!(:user_without_cars) do
    User.create!(
      email: 'without@example.com',
      password: 'qweqwe',
      last_login_at: Date.today - (period + 1.day)
    )
  end

  let!(:user_with_cars) do
    User.create!(
      email: 'with@example.com',
      password: 'qweqwe',
      last_login_at: Date.today - (period + 1.day),
      cars: [Car.create!(plate: 'CA1234XX')]
    )
  end

  context 'when notification was not sent' do
    it 'delivers notification' do
      expect_any_instance_of(UnfinishedRegistrationNotification).to receive(:deliver)

      UnfinishedRegistrationsNotifier.call(period)
    end
  end

  context 'when notification was sent' do
    before do
      UnfinishedRegistrationNotification.create!(
        user: user_without_cars,
        notifiable: user_without_cars,
      )
    end

    it 'does not deliver notification' do
      expect_any_instance_of(UnfinishedRegistrationNotification).not_to receive(:deliver)

      UnfinishedRegistrationsNotifier.call(period)
    end
  end
end
