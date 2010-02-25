desc "Daily cron job emails schedules for the upcoming week ONLY on fridays"
task :cron => :environment do
  if Time.now.wday == 5
    User.all.each do |user|
      team_urls = user.teams.map{|team| HashWithIndifferentAccess.new(team.attributes) }
      scheduled_matches = Schedule.find( team_urls )

      upcoming_matches = scheduled_matches.select{|match| Date.today <= match[:date] <= 1.week.from_today.to_date }
      ScheduleMailer.deliver_upcoming user, upcoming_matches
    end
  end
end
