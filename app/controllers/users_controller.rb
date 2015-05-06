class UsersController < ApplicationController
  layout "public"
  def show
    @user = User.friendly.find(params[:id])
    @machines = Machine.all
  end
end
