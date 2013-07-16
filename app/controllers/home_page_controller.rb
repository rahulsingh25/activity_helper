class HomePageController < ApplicationController
  def home
  	 @activity=current_user.activities.build if user_signed_in?
  	@activities=Activity.paginate(page: params[:page]) if user_signed_in?
  end
end
