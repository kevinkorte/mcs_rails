class MachinesController < ApplicationController
  layout "public"
  def index
    @machines = Machine.search(params[:search])
    @parts = Part.all
    @unit = Machine.friendly.first
    @machinelist = Machine.all.friendly.paginate(:page => params[:page], :per_page => 30)
    @machine = Machine.all
    respond_to do |format|
      format.html
      format.json { render json: @machine.to_json(:only => [:title, :slug]) }
    end
  end
  
  def show
    @machine = Machine.friendly.find(params[:id])
  end
  
  def queries
    @query = Machine.search(params[:search])
    respond_to do |format|
      format.json { render json: @query.to_json(:only => [:title, :slug]) }
    end
  end

  
end