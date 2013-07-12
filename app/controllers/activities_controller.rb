class ActivitiesController < ApplicationController
	before_filter :authenticate_user!
	
	def new
      @activity=Activity.new    
  end
  def create
  	  @activity = current_user.activities.new(params[:activity])
       if @activity.save
    	  flash[:notice] = "Activity created!"
     	  redirect_to root_url
      else
          @activities=Activity.paginate(page: params[:page])
      	  render 'home_page/home'
      end
	 end

  	def destroy
  	end

end
