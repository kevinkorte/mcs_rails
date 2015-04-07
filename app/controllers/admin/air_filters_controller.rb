class Admin::AirFiltersController < ApplicationController
    before_action :authenticate_admin!
    def index
        @airfilter = AirFilter.all
    end
    
    def show
        @airfilter = AirFilter.find(params[:id])
    end
    
    def new
        @airfilter = AirFilter.new
        @list_all_af = AirFilter.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 5)
    end
    
    def edit
        @airfilter = AirFilter.find(params[:id])
    end
    
    def create
        @airfilter = AirFilter.new(airfilter_params)
        if @airfilter.save
            redirect_to admin_parts_path
        else
            render :new
        end
    end
    
    def update
      @airfilter = AirFilter.find(params[:id])
      if @airfilter.update_attributes(airfilter_params)
        flash[:success] = "Updated Successfully!"
        redirect_to @airfilter
      else
        render 'edit'
      end
    end

    def destroy
    end
    
    private
        def airfilter_params
            params.require(:part).permit(:brand, :part_number)
        end
  
end
