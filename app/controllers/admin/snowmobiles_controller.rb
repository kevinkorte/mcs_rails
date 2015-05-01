class Admin::SnowmobilesController < ApplicationController
  
    def new
        @snowmobile = Snowmobile.new
        @list_all_snowmobile = Snowmobile.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 5)
    end
    
    def edit
        @snowmobile = Snowmobile.find(params[:id])
    end
    
    def create
        @snowmobile = Snowmobile.new(snowmobile_params)
        if @snowmobile.save
            redirect_to new_admin_snowmobile_path
        else
            render :new
        end
    end
    
    def update
      @snowmobile = Snowmobile.find(params[:id])
      if @snowmobile.update_attributes(snowmobile_params)
        flash[:success] = "Updated Successfully!"
        redirect_to @snowmobile
      else
        render 'edit'
      end
    end

    def destroy
    end
    
    private
        def snowmobile_params
            params.require(:snowmobile).permit(:title)
        end
  
  
end
