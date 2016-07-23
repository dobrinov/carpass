class NotificationsController < ApplicationController
  before_action :requires_login

  def index
    @notifications = current_user.notifications.order('CASE WHEN read_at IS NULL THEN 0 ELSE 1 END').order(created_at: :desc)
  end

  def read
    @notification = current_user.notifications.find(params[:id])

    if @notification.update_attributes(read_at: Time.now)
      redirect_to notification_path(@notification)
    else
      redirect_to notifications_path # where?
    end
  end

  private

  def notification_path(notification)
    case notification
    when ExpiringFullInsuranceHistoryNotification,
         ExpiringAnnualInspectionHistoryNotification,
         ExpiringCompulsoryInsuranceHistoryNotification
      history_path(notification.notifiable, referrer_param => notifications_path)
    when UnfinishedRegistrationNotification
      new_car_path
    when CarHistoryInactivityNotification
      car_path(notification.notifiable, referrer_param => notifications_path)
    else
      notifications_path
    end
  end
end
