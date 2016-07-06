namespace :users do
  desc "Notifies users about unfinished registration"
  task notify_unfinished_registrations: :environment do
    UnfinishedRegistrationsNotifier.call
  end
end
