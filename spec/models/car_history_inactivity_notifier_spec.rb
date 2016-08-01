require 'rails_helper'

RSpec.describe CarHistoryInactivityNotifier do
  let(:period) { 2.months }

  let!(:user_withiout_cars) do
    User.create!(
      email: 'with@example.com',
      password: 'qweqwe',
      last_login_at: Date.today - (period + 1.day)
    )
  end

  let!(:user_with_cars) do
    User.create!(
      email: 'without@example.com',
      password: 'qweqwe',
      last_login_at: Date.today - (period + 1.day),
      cars: [Car.create!(plate: 'CA1234XX')]
    )
  end

  let!(:ignored_user) do
    User.create!(
      email: 'ignored@example.com',
      password: 'qweqwe',
      last_login_at: Date.today
    )
  end

  let(:notification) { double(:notification) }

  context 'when notification was not delivered soon' do
    it 'delivers notifications' do
      expect_any_instance_of(CarHistoryInactivityNotification).to receive(:deliver)

      CarHistoryInactivityNotifier.call(period)
    end

    context 'when previous notifications' do
      before do
        notification = CarHistoryInactivityNotification.create!(
          user: user_with_cars,
          notifiable: user_with_cars.cars.first,
          created_at: Time.now - (period + 1.day)
        )
      end

      it 'delivers notifications' do
        expect_any_instance_of(CarHistoryInactivityNotification).to receive(:deliver)

        CarHistoryInactivityNotifier.call(period)
      end
    end
  end

  context 'when notification was delivered soon' do
    before do
      CarHistoryInactivityNotification.create!(
        user: user_with_cars,
        notifiable: user_with_cars.cars.first,
      )
    end

    it 'doesnt send notification' do
      expect_any_instance_of(CarHistoryInactivityNotification).not_to receive(:deliver)

      CarHistoryInactivityNotifier.call(period)
    end
  end
end
