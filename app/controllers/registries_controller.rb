class RegistriesController < ApplicationController
	before_filter :authenticate_user!

  # GET /registries
  # GET /registries.json
  def index
    # @registrations = Registration.all.page params[:page]
    # @people = Registration.all.page params[:page]  
    result        = Registry.search(params[:fromDate],
                                    params[:toDate],
                                    params[:purchaseDate],
                                    params[:dealerAccount],
                                    params[:dealerName],
                                    params[:flagship], 
                                    params[:model], 
                                    params[:serialNumber], 
                                    params[:territory], 
                                    params[:region],
                                    params[:firstName], 
                                    params[:lastName])

    @people       = result.page(params[:page]).per(10)

    # @people = Registration.find( {first_name: "Angel"});
    if request.xhr?
      @people       = result; 
      render(:print_view, :layout => false)
      return 
    end
    respond_to do |format|
    	format.html
    	format.csv { 
    		Rails.logger.debug("Search params: #{params[:dealerAccount]}")
   		# @people = Registry.search(params[:fromDate],params[:toDate],params[:purchaseDate],
      # params[:dealerAccount],params[:dealerName],params[:flagship], params[:model], params[:serialNumber], 
      # params[:territory], params[:region],
      # params[:firstName], params[:lastName]);
    		send_data result.to_csv }
    	# format.xls { send_data @people.to_csv(col_sep: "\t") }
    end
  end

  def data
    render json: Registry.to_datatable( 
        Registry.search(params[:fromDate],
                        params[:toDate],
                        params[:purchaseDate],
                        params[:dealerAccount],
                        params[:dealerName],
                        params[:flagship], 
                        params[:model], 
                        params[:serialNumber], 
                        params[:territory], 
                        params[:region],
                        params[:firstName], 
                        params[:lastName]).page(params[:page]), params[:sEcho])
  end
end
