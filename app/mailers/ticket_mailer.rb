class TicketMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ticket_mailer.secret.subject
  #
  def secret(ticket)
    @ticket = ticket
    mail(to: @ticket.client_email, subject: "Your Chaincare Support Chat Link")
  end
end
