class PartsController < ApplicationController
    def index
        @part = Part.all
    end
    
    def show
        @part = Part.find(params[:id])
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
