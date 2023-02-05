class SimulationRequestMailer < ApplicationMailer
  default from: 'jw@floatplane.dev'

  def request_created
    @record = params[:record]

    mail(
      to: 'ask@interflux.com.sg',
      cc: 'sw@floatplane.dev',
      bcc: 'jw@interflux.au',
      reply_to: @record.email,
      subject: "ICSF simulation request ##{@record.sequence}"
    )
  end
end
