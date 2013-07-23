class FriendshipsController < ApplicationController


	def create
		@friendship=current_user.friendships.build(friend_id: params[:friend_id])
		if @friendship.save
			FriendshipMailer.friendship_email(@friendship.user).deliver
			flash[:success]="Friend Request Sent!"
			redirect_to users_path
		else
			flash[:error]="Unable to add friend!"
			redirect_to users_path
		end
	end

	def destroy
		@friendship=current_user.friendships.find(params[:id])
		@friendship.destroy
		flash[:success]="Removed Friendship"
		redirect_to current_user
	end

	def update
		@friendship=current_user.inverse_friendships.find(params[:id])
		if @friendship.update_attributes(status: true)
			flash[:success]="Accepted!"
			redirect_to current_user
		else
			flash[:error]="Failed!"
			redirect_to current_user
		end

	end
end
