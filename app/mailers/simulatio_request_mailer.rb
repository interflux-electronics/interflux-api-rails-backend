class SimulatioRequestMailer < ApplicationMailer
  default from: 'jan.werkhoven@gamil.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.simulatio_request_mailer.request_created.subject
  #
  def request_created
    @greeting = "Hi"

    mail(to: "shuwen.w@hotmail.com", subject:'You have got a request')
  end
end


# Example from rails guide: I do not understand the usage of @user & @url
#   def welcome_email
#     @user = params[:user]
#     @url  = 'http://example.com/login'
#     mail(to: @user.email, subject: 'Welcome to My Awesome Site')
#   end
# end
