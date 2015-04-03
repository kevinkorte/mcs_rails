class PartsController < ApplicationController
    def index
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
        @machines = Machine.all
    end
    
    def create
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
    end
    
    private
    
    def update_params
        params.require(:part).permit(:brand, :part_number)
    end
end
