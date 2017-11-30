class RequestMailer < ApplicationMailer
  def confirm(request)
    @request = request

    mail to: @request.email, subject: "Hey #{@request.name}, please confirm your email address to join Workstation's waiting list"
  end

  def reconfirm(request)
    @request = request

    mail to: @request.email, subject: "Hey #{@request.name}, please reconfirm your email address to stay in Workstation's waiting list"
  end
end
