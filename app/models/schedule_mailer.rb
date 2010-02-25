class ScheduleMailer < ActionMailer::Base
  

  def upcoming(sent_at = Time.now)
    subject    'ScheduleMailer#upcoming'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
