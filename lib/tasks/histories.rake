namespace :histories do
  desc "Notifies users about future expiration of histories"
  task notify_expiration: :environment do
    HistoryExpirationNotifier.call
  end
end
