class UsersController < ApplicationController
	# before_filter :authenticate_user!

	def show
		@user=User.find(params[:id])
		@activities = @user.activities.paginate(page: params[:page])
	end
end

