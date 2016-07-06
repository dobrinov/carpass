class UnfinishedRegistrationsNotifier
  attr_reader :logger

  def initialize
    @logger = Logger.new("#{Rails.root}/log/unfinished_registrations_notifier.log", 'a')
  end

  def self.call
    new.call
  end

  def call
    # Implement me
  end

  private

  def users
    # Implement me
  end
end
