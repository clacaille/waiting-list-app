class RequestsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @request = Request.new
  end


  def create
    @request = Request.new(request_params)
    if @request.save
      RequestMailer.confirm(@request).deliver_now
      redirect_to root_path
    else
      render :new
    end
  end

  def confirm
    @request = Request.find(params[:request])
    if @request.email == params[:email]
      @request.confirmed = true
      @request.save
    else
      redirect_to root_path
    end
  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :phone_number, :biography)
  end
end
