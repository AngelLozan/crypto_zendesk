# Preview all emails at http://localhost:3000/rails/mailers/ticket_mailer
class TicketMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/ticket_mailer/secret
  def secret
    ticket = Ticket.first
    TicketMailer.secret(ticket)
  end

end
