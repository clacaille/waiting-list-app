class RequestsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @request = Request.new
  end


  def create
    @request = Request.new(request_params)
    if @request.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :phone_number, :biography)
  end
end