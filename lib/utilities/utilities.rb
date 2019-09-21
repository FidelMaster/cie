class Utilities::Utilities
  
  def initialize()
    @hash = {}
  end

  def add(key_value)
    key_value.each do |key, value|
      @hash[key] = value
    end
    self
  end

  def entries
    @hash
  end

  def keywords
     @hash.keys
  end

  WEEK_NUMBER_FORMAT = '%W'

  def first_day_of_month(date=Date.today)
    date.beginning_of_month
  end

  def last_day_of_month(date=Date.today)
    date.end_of_month
  end

  def week_number(date=Date.today)
    date.strftime(WEEK_NUMBER_FORMAT).to_i
  end

  def weeks_in_month(date=Date.today)
    week_number(last_day_of_month(date)) - week_number(first_day_of_month(date))  + 1
  end

  def week_of_month_for_date(date=Date.today)
    week_of_target_date = date.strftime("%U").to_i
    week_of_beginning_of_month = date.beginning_of_month.strftime("%U").to_i
    week_of_target_date - week_of_beginning_of_month + 1
  end

  def days_by_week_list(date=Date.today)
    (first_day_of_month(date).to_date..last_day_of_month(date).to_date).each do |day|
      if (1..5).include?(day.wday)
        self.add("#{day}" => week_of_month_for_date(day))
        #week_list.push([day, week_of_month_for_date(day)])
      end
    end
    @hash
  end

end
