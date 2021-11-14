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
end