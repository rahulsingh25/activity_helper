class FriendshipMailer < ActionMailer::Base
  default from: "bigcolors@akaruilabs.com"

  def friendship_email(user)
  	@user = user
    mail(to: @user.email, subject: "#{@user.username} has sent you a friend request")
  end
end
