class Admin::MachinesController < ApplicationController
    before_action :authenticate_admin!
    def index
        @machine = Machine.ransack(params[:q])
        @results = @machine.result.order(created_at: :desc).paginate(:page => params[:page], :per_page => 30)
    end
    
    def show
        @machine = Machine.friendly.find(params[:id])
    end
    
    def new
        @machine = Machine.new
        @machine.categorizations.build.build_term
        @list_all_m = Machine.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 5)
    end
    
    def edit
        @machine = Machine.friendly.find(params[:id])
        @parts = Part.all
    end
    
    def create
        @machine = Machine.new(machine_params)
        if @machine.save
            flash[:success] = "New machine successfully added!"
            redirect_to admin_machines_path
        else
            render :new
        end
    end
    
    def update
        @machine = Machine.friendly.find(params[:id])
        if @machine.attributes = {'part_ids' => []}.merge(params[:machine] || {})
            @machine.update_attributes(machine_params)
            flash[:success] = "Updated Successfully!"
            redirect_to action: "show", id: @machine
        else
            render "edit"
        end
    end

    def destroy
        Machine.friendly.find(params[:id]).destroy
        flash[:notice] = "Part Successfully Deleted!"
        redirect_to admin_machines_path
    end
    
     def term_attributes=(attributes)
            self.title = Term.find_or_create_by_name(attributes[:name])
     end
    
    
    private
        def machine_params
            params.require(:atv).permit(:id, :title)
        end
end