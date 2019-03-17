class BlocksController < ApplicationController
    before_action :authenticate_user
    def create
        @user = User.find(params[:id])
        @current_user.block(@user) unless @current_user.blocked?(@user)
    end

    def destroy
        @user = User.find(params[:id])
        @current_user.unblock(@user) if @current_user.blocked?(@user)
    end
end