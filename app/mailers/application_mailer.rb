class ApplicationMailer < ActionMailer::Base
  default from: "Carpass.bg <no-reply@carpass.bg>"
  layout 'mailer'

  before_action :attach_logo
  before_action :attach_background

  private

  def attach_logo
    attachments.inline['logo.png'] = File.read("#{Rails.root.to_s + '/app/assets/images/logo_56x46.png'}")
  end

  def attach_background
    attachments.inline['background.png'] = File.read("#{Rails.root.to_s + '/app/assets/images/bg_pattern_symphony.png'}")
  end
end
