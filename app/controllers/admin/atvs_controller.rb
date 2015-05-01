class Admin::AtvsController < ApplicationController
  
    def new
        @atv = Atv.new
        @list_all_atv = Atv.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 5)
    end
    
    def edit
        @atv = Atv.find(params[:id])
    end
    
    def create
        @atv = Atv.new(atv_params)
        if @atv.save
            redirect_to new_admin_atv_path
        else
            render :new
        end
    end
    
    def update
      @atv = Atv.find(params[:id])
      if @atv.update_attributes(atv_params)
        flash[:success] = "Updated Successfully!"
        redirect_to @atv
      else
        render 'edit'
      end
    end

    def destroy
    end
    
    private
        def atv_params
            params.require(:atv).permit(:title)
        end
  
  
end
