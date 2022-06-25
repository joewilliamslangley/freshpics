class UserPlatformsController < ApplicationController
  def index
    @user = current_user
    @platforms = Platform.all
  end

  def set_user_platforms
    # raise
    selection = params[:platform_ids]
    UserPlatform.where(user: current_user).delete_all

    if selection
      selection.each do |id|
        UserPlatform.create!(user: current_user, platform_id: id)
      end
    end
    redirect_to user_path(current_user), notice: 'Your saved platforms have been updated'
  end
end
