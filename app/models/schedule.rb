class Schedule
  require 'nokogiri'
  require 'open-uri'

  class << self
    def find( team_urls )
      return [ ] if team_urls.empty?
      schedule = team_urls.collect do |team_url_info|
        doc = begin
          Nokogiri::HTML( open(team_url_info[:url]) )
        rescue
          nil
        end
        if doc
          rows = doc.css("tr.GameRow").collect do |game_row|
            RAILS_DEFAULT_LOGGER.info "Date read: #{game_row['date']}"
            game_info = { :date=>game_row['date'].to_date }
            
            if Rails.env=='production'
              game_info.merge!( :time => Time.parse("#{game_info[:date].strftime('%Y-%m-%d')} #{game_row['time']}") )
            else
              date_parts = ParseDate.parsedate( game_row['time'] )
              date_parts[0] = game_info[:date].year
              date_parts[1] = game_info[:date].month
              date_parts[2] = game_info[:date].day
              game_info.merge!( :time => Time.mktime(*date_parts) )
            end

            game_info.merge!( :field => scrub_text( game_row.css('td.facility a').text ) )
            game_info.merge( :match => game_row.css('td.tm').collect{|team_link| scrub_text(team_link.text)}.join(' vs ') )
          end
        else
          [ ]
        end
      end

      schedule.flatten
    end

    def scrub_text( text )
      text.gsub(/\r\n/, '').strip
    end
  end
end
