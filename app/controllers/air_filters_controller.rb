class AirFiltersController < ApplicationController
    def index
        @airfilter = AirFilter.all
    end
    
    def show
        @airfilter = AirFilter.find(params[:id])
    end
    
    def new
        @airfilter = AirFilter.new
    end
    
    def edit
        @airfilter = AirFilter.find(params[:id])
    end
    
    def create
    end
    
    def update
    end

    def destroy
    end
end
