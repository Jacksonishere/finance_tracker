class UserStocksController < ApplicationController
  def create
    stock = Stock.check_stock(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added"
    redirect_to portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.get_user_stock(current_user.id, params[:id])
    user_stock.destroy
    flash[:notice] = "You are not longer tracking #{stock.ticker}"
    redirect_to portfolio_path
  end
  
end
