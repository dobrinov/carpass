namespace :users do
  desc "Notifies users about unfinished registration"
  task :notify_unfinished_registrations, [:period] => [:environment] do |t, args|
    period = args[:period].to_i.days
    UnfinishedRegistrationsNotifier.call(period)
  end
end
