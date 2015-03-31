class MachinesController < ApplicationController
    
    def index
        @machine = Machine.all
    end
    
    def show
        @machine = Machine.find(params[:id])
        #@airfilter = Machine.find(params[:id]).parts
    end
    
    def new
    end
    
    def edit
    end
    
    def create
    end
    
    def update
    end

    def destroy
    end
    
end
