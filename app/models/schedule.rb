class Schedule
  require 'nokogiri'
  require 'open-uri'

  class << self
    def find( team_url )
      doc = begin
        Nokogiri::HTML( open(team_url) )
      rescue
        nil
      end

      if doc
        if doc.css('tr.GameRow').size > 0
          return doc.css('tr.GameRow').collect do |game_row|
            game_info = {  }
            
            parts = game_row['date'].split(/\//)
            game_date = Date.parse( parts.unshift( parts.pop ).join('-') )
            game_info.merge!( :date => game_date, :time => Time.parse("#{game_date.strftime('%Y-%m-%d')} #{game_row['time']}") )

            game_info.merge!( :game_time => game_info[:time].strftime('%l:%M %p') )
            game_info.merge!( :field => scrub_text( game_row.css('td.facility a').text ) )
            game_info.merge( :match => game_row.css('td.tm').collect{|team_link| scrub_text(team_link.text)}.join(' vs ') )
          end
        end

        if doc.css('tr.sch-main-gm').size > 0
          this_year = Date.today.year.to_s

          return doc.css('tr.sch-main-gm').collect do |game_row|
            game_info = { }

            game_date = game_row.css('td')[3].text + ' ' + this_year
            game_info.merge!( :date => game_date.to_date )
 
            game_time = game_date + ' ' + game_row.css('td')[4].text
            game_info.merge!( :time => game_time.to_time, :game_time => game_time.to_time.strftime('%l:%M %p') )
 
            game_info.merge!( :field => scrub_text( game_row.css('td span.tmcode').text ) )

            game_info.merge!( :match => game_row.css('td.schedtm').collect{|team_link| scrub_text(team_link.text)}.join(' vs ') )
            Rails.logger.info game_info.inspect

            return game_info
          end
        end
      else
        [ ]
      end
    end

    def scrub_text( text )
      text.gsub(/\r\n/, '').strip
    end
  end
end
