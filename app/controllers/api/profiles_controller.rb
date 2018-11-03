class Api::ProfilesController < Api::ApplicationController

  def create
  end



  private

  def user_params
    params.require(:user).permit(:email)
  end
end
