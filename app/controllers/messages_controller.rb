class MessagesController < ApplicationController
	def create
		# raise params.to_yaml
		@message=current_user.messages.build(message: params[:text][:message],recipient_id: params[:recipient_id])
		if @message.save
			user=User.find(params[:recipient_id])
			flash[:success]="Message sent Successfully!"
			redirect_to user
		else
			user=User.find(params[:recipient_id])
			flash[:error]="Failed to send message!"
			redirect_to user
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
