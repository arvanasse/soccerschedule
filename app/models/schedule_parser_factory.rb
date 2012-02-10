class ScheduleParserFactory
  def self.find( links )
    return [] if links.empty?

    links.collect do |schedule_link|
      case
        when schedule_link[:url] =~ /scyouthsoccer/i
          ScheduleScysa.find schedule_link[:url]
        else
          Schedule.find schedule_link[:url]
      end
    end.flatten
  end
end
