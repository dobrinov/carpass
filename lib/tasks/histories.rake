namespace :histories do
  desc "Notifies users about future expiration of histories"
  task notify_expiration: :environment do
    logger = Logger.new("#{Rails.root}/log/history_expiration_notifier.log", 'a')
    logger.info 'Executing histories notifier rake job'
    HistoryExpirationNotifier.call
  end
end
