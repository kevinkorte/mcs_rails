
    class Admin::PartsController < ApplicationController
        before_action :authenticate_admin!
        def index
            @q = Part.ransack(params[:q])
            @results = @q.result.paginate(:page => params[:page])
        end
        
        def show
             @part = Part.find(params[:id])
        end
        
        def new
            @part = Part.new
            @machines = Machine.all
        end
        
        def edit
            @part = Part.find(params[:id])
            @machines = Machine.all
        end
        
        def create
           @part = Part.new(new_params)
           if @part.save
               redirect_to admin_parts_path
           else
               render 'new'
           end
        end
        
        def update
            @part = Part.find(params[:id])
            if @part.attributes = {'machine_ids' => []}.merge(params[:part] || {})
                @part.update_attributes(update_params)
                flash[:notice] = 'Successful Update'
                redirect_to action: 'show', id: @part
            else
                render :action => 'edit'
            end
        end
    
        def destroy
            Part.find(params[:id]).destroy
            flash[:notice] = "Part Successfully Deleted!"
            redirect_to admin_parts_path
        end
        
        private
        
        def update_params
            params.require(:part).permit(:brand, :part_number)
        end
        
        def new_params
            params.require(:part).permit(:brand, :part_number)
        end
    end

