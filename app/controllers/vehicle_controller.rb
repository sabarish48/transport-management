class VehicleController < ApplicationController
  def index
    unless session[:user_id]
      flash[:notice] = "Please log in first"
      redirect_to :action => "login"
      return
    end    
    @user = User.find(session[:user_id])
    @vehicles = Vehicle.all    
  end

  def search
    unless session[:user_id]
      flash[:notice] = "Please log in first"
      redirect_to :action => "login"
      return
    end
    if params[:vehicle].present?    
      @vehicles = Vehicle.find_all_by_from_and_to_and_main_type_and_sub_type(params[:vehicle][:from], params[:vehicle][:to], params[:vehicle][:type], params[:vehicle][:sub_type])
      @vehicles = @vehicles.select{|veh| veh.available > params[:vehicle][:available].to_i}
    else
      @vehicles = []
    end    
  end

  def register
    @title = "Register New Vehicle"
    if param_posted?(:vehicle)
      @vehicle = Vehicle.new(params[:vehicle])
      if @vehicle.save
        @vehicle.available = @vehicle.capacity
        @vehicle.save!
        flash[:notice] = "Vehicle #{@vehicle.number} created!"
        redirect_to_forwarding_url
      else
        flash[:error] = "Problem Creating Vehicle #{@vehicle.number}!"
      end
    end
  end

  private

  # Return true if a parameter corresponding to the given symbol was posted.
  def param_posted?(symbol)
    request.post? and params[symbol]
  end
  
  # Redirect to the previously requested URL (if present).
  def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => "index"
    end
  end
end
