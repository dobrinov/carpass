class TimeInterval
  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def days
    (end_date - start_date).to_i
  end

  def months
    ((end_date - start_date) / (1.month / 1.day)).to_i
  end

  def years
    ((end_date - start_date) / (1.year / 1.day)).to_i
  end
end
