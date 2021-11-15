class SearchesController < ApplicationController
  def stock
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock].upcase)
      if @stock
        respond_to do |format|
          #expects a js.erb now
          #since we in stocks controller, looks under stocks/
          format.js { render partial: 'stocks/data' }
        end
      else
        flash.now[:alert] = "Please enter a valid symbol to search"
        respond_to do |format|
          format.js { render partial: 'stocks/data' }
        end
        # respond_to do |format|
        #   #since this is in a shared partial folder, need to explicitly state the path
        #   format.js { render partial: 'shared/flashes'}
        # end
      end    
      
    else
      flash.now[:alert] = "Please enter a symbol!"
      respond_to do |format|
        format.js { render partial: 'stocks/data' }
      end
    end
  end


  def person
    if params[:person].present?
      @users = User.search(params[:person].downcase)
      @users = current_user.except_current_user(@users)
      if @users
        respond_to do |format|
          format.js { render partial: 'users/data' }
        end
      else
        flash.now[:alert] = "User not found. Try again"
        respond_to do |format|
          format.js { render partial: 'users/data' }
        end
      end    
      
    else
      flash.now[:alert] = "Please enter a email!"
      respond_to do |format|
        format.js { render partial: 'users/data' }
      end
    end
  end



end
