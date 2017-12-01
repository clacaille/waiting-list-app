class ReconfirmWorker
  include Sidekiq::Worker

  def perform(request_id)
    request = Request.find(request_id)
    if request.accepted == false
      request.confirmed = false
      request.save
      RequestMailer.reconfirm(request).deliver_now
      ExpireWorker.perform_in(1.weeks, request_id)
    end
  end
end
