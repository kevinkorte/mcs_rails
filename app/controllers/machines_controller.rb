class MachinesController < ApplicationController
  layout "public"
  def index
    @machines = Machine.search(params[:search])
    @machine = Machine.all
    respond_to do |format|
      format.html
      format.json { render json: @machine.to_json(:only => [:title, :slug]) }
    end
    
  end
  
  def show
    @machine = Machine.friendly.find(params[:id])
  end

  
end