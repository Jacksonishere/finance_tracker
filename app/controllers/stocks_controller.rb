class StocksController < ApplicationController
  
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          #expects a js.erb now
          #since we in stocks controller, looks under stocks/
          format.js { render partial: 'data' }
        end
      else
        flash.now[:alert] = "Please enter a valid symbol to search"
        respond_to do |format|
          format.js { render partial: 'data' }
        end
        # respond_to do |format|
        #   #since this is in a shared partial folder, need to explicitly state the path
        #   format.js { render partial: 'shared/flashes'}
        # end
      end    
      
    else
      flash.now[:alert] = "Please enter a symbol!"
      respond_to do |format|
        format.js { render partial: 'data' }
      end
    end
  end

end
