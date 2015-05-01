class Admin::MotorcyclesController < ApplicationController
  
    def new
        @motorcycle = Motorcycle.new
        @list_all_motorcycle = Motorcycle.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 5)
    end
    
    def edit
        @motorcycle = Motorcycle.find(params[:id])
    end
    
    def create
        @motorcycle = Motorcycle.new(motorcycle_params)
        if @motorcycle.save
            redirect_to new_admin_motorcycle_path
        else
            render :new
        end
    end
    
    def update
      @motorcycle = Motorcycle.find(params[:id])
      if @motorcycle.update_attributes(motorcycle_params)
        flash[:success] = "Updated Successfully!"
        redirect_to @motorcycle
      else
        render 'edit'
      end
    end

    def destroy
    end
    
    private
        def motorcycle_params
            params.require(:motorcycle).permit(:title)
        end
  
  
end
