module Statistics
  class HistoryCreations < Base
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def labels
      (start_date.to_date..end_date).map { |date| date }
    end

    def datasets
      [
        history_creations_dataset
      ]
    end

    private

    def history_creations_dataset
      {
        label: 'Добавени истории',
        data: history_creations_dataset_data
      }
    end

    def history_creations_dataset_data
      data = Array.new(labels.count, 0)

      history_creations.each do |history_creation|
        data[labels.index(history_creation.date)] = history_creation.count
      end

      data
    end

    def history_creations
      @_history_creations ||= History.where("created_at >= :creation_date AND created_at <= :today", { creation_date: start_date, today: end_date })
                                     .select("date(created_at) as date, count(*) as count")
                                     .group("date(created_at)").to_a
    end
  end
end
