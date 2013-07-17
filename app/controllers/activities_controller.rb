class ActivitiesController < ApplicationController
	before_filter :authenticate_user!, only: [:new,:create,:destroy]
  respond_to :html,:xml,:json	
	def new
      @activity=Activity.new    
  end
  def create
  	  @activity = current_user.activities.new(params[:activity])
      if @activity.save
        @activities=Activity.paginate(page: params[:page])
        respond_with do |format|
          format.html do
            if request.xhr?
              render partial: 'activity', layout:false, status: :created, :locals => {:activity=>@activities.first}
            end
          end
        end
      else
        respond_with do |format|
          format.html do
            if request.xhr?
              render partial: 'new_partial', layout:false, status: :error

            end
          end
        end
      end
	 end

  	def destroy
      
  	end

    def index
      
    end

end
