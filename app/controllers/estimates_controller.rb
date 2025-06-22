class EstimatesController < ApplicationController
  before_action :set_estimate, only: [:show, :edit, :update, :destroy]

  def index
    @estimates = Estimate.all
  end

  def new
    @estimate = Estimate.new
  end

  def create
    @estimate = Estimate.new(estimate_params)
    
    if @estimate.save
      redirect_to @estimate, notice: '見積書が作成されました。'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @estimate.update(estimate_params)
      redirect_to @estimate, notice: '見積書が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @estimate.destroy
    redirect_to estimates_path, notice: '見積書が削除されました。'
  end

  private

  def set_estimate
    @estimate = Estimate.find(params[:id])
  end

  def estimate_params
    params.require(:estimate).permit(:title, :client, :amount, :status)
  end
end
