require "test_helper"

class TicketMailerTest < ActionMailer::TestCase
  test "secret" do
    mail = TicketMailer.secret
    assert_equal "Your Chaincare Support Chat Link", mail.subject
    assert_equal [Ticket.first], mail.to
    assert_equal ["support@chaincare.tech"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
