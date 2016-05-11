class Lunar
  def self.next_spring_festival(date=Date.current)
    # date = Date.current unless date.nil?
    1.upto(720) do |i|
      if ChineseLunar::Lunar.new(date + i.days).lunar_date_in_chinese.include?("正月 初一")
        return date + i.days
      end
    end
  end

  def self.last_spring_festival(date=Date.current)
    # date = Date.current unless date.nil?
    1.upto(720) do |i|
      if ChineseLunar::Lunar.new(date - i.days).lunar_date_in_chinese.include?("正月 初一")
        return date - i.days
      end
    end
  end

  def self.lunar_year_length(date=Date.current)
    (self.next_spring_festival(date) - self.last_spring_festival(date)).to_i
  end
end
