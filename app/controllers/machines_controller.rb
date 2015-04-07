class MachinesController < ApplicationController
  layout "public"
  def index
    @machines = Machine.ransack(params[:q])
    @results = @machines.result.order(created_at: :desc).paginate(:page => params[:page], :per_page => 30)
  end
  
  def show
    @machines = Machine.ransack(params[:q])
    @machine = Machine.friendly.find(params[:id])
  end
end