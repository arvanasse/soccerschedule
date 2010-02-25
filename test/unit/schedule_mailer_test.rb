require 'test_helper'

class ScheduleMailerTest < ActionMailer::TestCase
  test "upcoming" do
    @expected.subject = 'ScheduleMailer#upcoming'
    @expected.body    = read_fixture('upcoming')
    @expected.date    = Time.now

    assert_equal @expected.encoded, ScheduleMailer.create_upcoming(@expected.date).encoded
  end

end
