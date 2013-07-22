class FriendshipsController < ApplicationController


	def create
		@friendship=current_user.friendships.build(friend_id: params[:friend_id])
		# raise @friendship.to_yaml
		if @friendship.save
			flash[:success]="Friend Added!"
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
end
