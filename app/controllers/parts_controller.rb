class PartsController < ApplicationController
    def index
        @part = Part.all
        
        @q = Part.ransack(params[:q])
        @results = @q.result
    end
    
    def show
        @part = Part.find(params[:id])
    end
    
    def new
        @part = Part.new
    end
    
    def edit
        @part = Part.find(params[:id])
    end
    
    def create
    end
    
    def update
    end

    def destroy
    end
end
