class UsersController < ApplicationController
	# before_filter :authenticate_user!

	def show
		@user=User.find_by_username(params[:id])
		@activities = @user.activities.paginate(page: params[:page])
		@comment=@user.comments.build if user_signed_in?
	end

	def index
		if user_signed_in?
			@users=User.all
		else
			redirect_to root_url
		end
		
	end
end

