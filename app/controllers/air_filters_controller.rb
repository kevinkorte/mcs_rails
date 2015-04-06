class AirFiltersController < ApplicationController
    before_action :authenticate_admin!
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
        @airfilter = AirFilter.new(airfilter_params)
        if @airfilter.save
            redirect_to @airfilter
        else
            render :new
        end
    end
    
    def update
      @airfilter = AirFilter.find(params[:id])
      if @airfilter.update_attributes(airfilter_params)
        flash[:success] = "Update Successful"
        redirect_to @airfilter
      else
        render 'edit'
      end
    end

    def destroy
    end
    
    private
        def airfilter_params
            params.require(:air_filter).permit(:brand, :part_number)
        end
end
