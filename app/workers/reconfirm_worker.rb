class ReconfirmWorker
  include Sidekiq::Worker

  def perform(request_id)
    request = Request.find(request_id)
    request.confirmed = false
    request.expired = true
    RequestMailer.reconfirm(request).deliver_now
  end
end
