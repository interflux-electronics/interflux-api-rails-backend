# How to use:
# SimulationRequestMailer.request_created.deliver_now
class SimulationRequestMailer < ApplicationMailer
  default from: 'jw@floatplane.dev'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.simulatio_request_mailer.request_created.subject
  #
  def request_created
    @project_name = params[:project_name]
    @pallet_width = params[:pallet_width]
    @pallet_height = params[:pallet_height]
    @wave_speed = params[:wave_speed]
    @cycle_time = params[:cycle_time]
    @flux_brand = params[:flux_brand]
    @flux_consumption = params[:flux_consumption]
    @board_reference = params[:board_reference]
    @known_issue = params[:known_issue]
    @solder_process = params[:solder_process]
    @flux_process = params[:flux_process]
    @full_name = params[:full_name]
    @email = params[:email]
    @company_name = params[:company_name]

    mail(
      to: 'sw@floatplane.dev',
      cc: 'jw@floatplane.dev',
      reply_to: @email,
      subject: 'Simulation request'
    )
  end
end

# Example from rails guide: I do not understand the usage of @user & @url
#   def welcome_email
#     @user = params[:user]
#     @url  = 'http://example.com/login'
#     mail(to: @user.email, subject: 'Welcome to My Awesome Site')
#   end
# end
