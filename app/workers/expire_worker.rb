class ExpireWorker
  include Sidekiq::Worker

  def perform(request_id)
    request = Request.find(request_id)
    if request.confirmed == false
      request.expired = true
      request.confirm_token = nil
      request.remove_from_list
      request.save
    end
  end
end
