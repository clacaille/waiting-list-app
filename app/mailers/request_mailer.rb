class RequestMailer < ApplicationMailer
  def confirm(request)
    @request = request

    mail to: @request.email, subject: "Hey #{@request.name}, please confirm your email address to join Workstation's waiting list"
  end
end
