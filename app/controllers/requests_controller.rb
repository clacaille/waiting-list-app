class RequestsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      @request.remove_from_list
      RequestMailer.confirm(@request).deliver_now
      redirect_to root_path
    else
      render :new
    end
  end

  def confirm
    @request = Request.find_by_confirm_token(params[:token])
    if @request
      @request.confirmed = true
      @request.confirmation_token
      @request.save
      if @request.position.nil?
        @request.insert_at
        @request.move_to_bottom
      end
      ReconfirmWorker.perform_in(3.months, @request.id)
      # flash message to be added
      redirect_to root_path
    else
      # flash message to be added
      redirect_to root_path
    end
  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :phone_number, :biography)
  end
end
