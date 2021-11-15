class UsersController < ApplicationController
  def portfolio
    @tracked_stocks = current_user.stocks
  end

  def friends
    byebug
    @friends = current_user.friends
  end
end
