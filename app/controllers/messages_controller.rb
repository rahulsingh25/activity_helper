class MessagesController < ApplicationController
	def create
		# raise params.to_yaml
		@message=current_user.messages.build(message: params[:text][:message],recipient_id: params[:recipient_id])
		if @message.save
			flash[:success]="Message sent Successfully!"
			redirect_to current_user
		else
			flash[:error]="Failed to send message!"
			redirect_to current_user
		end
	end

	# def destroy
	# 	friendship=Friendship.find(params[:friendship_id])
	# 	@message=friendship.messages.find(params[:id])
	# 	@message.destroy
	# 	flash[:success]="Message Deleted!"
	# 	redirect_to friendship.friend
	# end
end
