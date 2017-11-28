# Preview all emails at http://localhost:3000/rails/mailers/request_mailer
class RequestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/confirm_action
  def confirm_action
    RequestMailerMailer.confirm_action
  end

end
