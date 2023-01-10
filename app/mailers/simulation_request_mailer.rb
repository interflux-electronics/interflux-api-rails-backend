class SimulationRequestMailer < ApplicationMailer
  default from: 'jw@floatplane.dev'

  def request_created
    @record = params[:record]

    # TODO: send to ask@interflux.com.sg

    mail(
      to: 'sw@floatplane.dev',
      cc: 'jw@floatplane.dev',
      reply_to: @record.email,
      subject: "ICSF simulation request ##{@record.sequence}"
    )
  end
end
