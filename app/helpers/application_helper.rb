module ApplicationHelper

	def correct_user
		if User.find_by_username(params[:id]).username == current_user.username
			return TRUE
		else
			return FALSE
		end
	end
end
