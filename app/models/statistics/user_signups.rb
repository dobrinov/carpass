module Statistics
  class UserSignups < Base
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def labels
      (1.month.ago.to_date..Date.today).map { |date| date }
    end

    def datasets
      [
        signups_dataset
      ]
    end

    private

    def signups_dataset
      {
        label: 'Регистрации',
        data: signups_dataset_data
      }
    end

    def signups_dataset_data
      data = Array.new(labels.count, 0)

      signups.each do |signup|
        data[labels.index(signup.date)] = signup.count
      end

      data
    end

    def signups
      @_signups ||= User.where("created_at >= :registration_date AND created_at <= :today", { registration_date: start_date, today: end_date })
                        .select("date(created_at) as date, count(*) as count")
                        .group("date(created_at)").to_a
    end
  end
end
