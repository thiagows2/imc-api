class ImcController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :set_imc, only: [:show, :update, :destroy]
  before_action :require_token

  def index
    @imcs = Imc.all

    render json: @imcs
  end

  def show
    render json: @imc
  end

  def create
    @imc = Imc.new(imc_params)

    if @imc.save
      render json: @imc, status: :created, location: @api_imc
    else
      render json: @imc.errors, status: :unprocessable_entity
    end
  end

  def update
    if @imc.update(imc_params)
      render json: @imc
    else
      render json: @imc.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @imc.destroy
  end

  private

  def set_imc
    @imc = Imc.find(params[:id])
  end

  def imc_params
    params.require(:imc).permit(:height, :weight)
  end

  def require_token
    authenticate_or_request_with_http_token do |token, options|
      Jwt.exists?(access_token: token)
    end
  end
end