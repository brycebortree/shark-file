class HomeController < ApplicationController
  skip_before_action :authenticate_tenant!, :only => [ :index ]

  def index
  	if current_user
  		if session[:tenant_id]
  			Tenant.set_current_tenant session[:tenant_id]
  		else
  			Tenant.set_current_tenant current_user.tenants.first
  		end

  		@tenant = Tenant.current_tenant
  		@projects = Project.by_plan_and_tenant(@tenant.id)
  		params[:tenant_id] = @tenant.id
  	end
  end

  def new()
    @member = Member.new()
    @user   = User.new()
  end

  def create()
    @user   = User.new( user_params )

    # ok to create user, member
    if @user.save_and_invite_member() && @user.create_member( member_params )
      flash[:notice] = "New member added and invitation email sent to #{@user.email}."
      redirect_to root_path
    else
      flash[:error] = "errors occurred!"
      @member = Member.new( member_params ) # only used if need to revisit form
      render :new
    end

  end


  private

  def member_params()
    params.require(:member).permit(:first_name, :last_name)
  end

  def user_params()
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  
end
