class Api::V1::UserFeedsController < Api::ApiController
  include Trailblazer::Operation::Controller

  def index
    render json: UserFeed.all
  end

  def create
    run UserFeed::Create
    render json: @model
  end

  def destroy
    UserFeed.find(params[:id]).destroy
    head :ok
  end

  private

  def process_params!(params)
    params.merge!(current_user: current_user)
  end
end
