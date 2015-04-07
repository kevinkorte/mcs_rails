class MachinesController < ApplicationController
  layout "public"
  def index
    @machines = Machine.ransack(params[:q])
    @results = @machines.result.paginate(:page => params[:page], :per_page => 5)
  end
  
  def show
    @machines = Machine.ransack(params[:q])
    @machine = Machine.friendly.find(params[:id])
  end
end