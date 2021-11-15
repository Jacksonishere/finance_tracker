class UsersController < ApplicationController
  def friends
    @friends = current_user.friends
  end

  # both these render the portfolio table. 
  def portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end


end
