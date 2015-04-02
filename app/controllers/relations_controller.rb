class RelationsController < ApplicationController
  
    def index
      @parts = Part.all
      @machines = Machine.all
      
      @q = Fitment.ransack(params[:q])
      @part = @q.result(distinct: true)
    end
    
    def show
      @relation = Fitment.find(params[:id])
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
