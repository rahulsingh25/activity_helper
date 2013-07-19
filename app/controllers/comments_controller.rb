class CommentsController < ApplicationController
	before_filter :authenticate_user!
	respond_to :html,:xml,:json
	def create
		user_id=User.find_by_username(params[:user_id])
		activity=user_id.activities.find(params[:activity_id])
		@comment=activity.comments.new(params[:comment])	
		@comment.user=current_user

		if @comment.save
			@comments=activity.comments.all
			respond_with do |format|
          		format.html do
            		if request.xhr?
           				render partial: 'comment', layout:false, status: :created, locals:{ activity: activity, comment:@comments.first }
           			else
           	 			flash[:success]="comment created!"
						redirect_to root_url
					end
				end
			end
		else
			respond_with do |format|
        		format.html do
          			if request.xhr?
           				render partial: 'new_comment_form', layout:false, status: :error, locals:{ activity: activity,comment:@comment }
          			else
          				flash[:error]="error"
						redirect_to root_url
					end
				end	
			end
		end
	end

	def show
		
	end
end
