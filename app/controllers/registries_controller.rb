class RegistriesController < ApplicationController
	before_filter :authenticate_user!

  # GET /registries
  # GET /registries.json
  def index
#    @registrations = Registration.all.page params[:page]
#    @people = Registration.all.page params[:page]  
   	@peoplenopage = Registry.search(params[:fromDate],params[:toDate],params[:purchaseDate],
      params[:dealerAccount],params[:dealerName],params[:flagship], params[:model], params[:serialNumber], 
      params[:territory], params[:region],
      params[:firstName], params[:lastName])
     @people = Registry.search(params[:fromDate],params[:toDate],params[:purchaseDate],
      params[:dealerAccount],params[:dealerName],params[:flagship], params[:model], params[:serialNumber], 
      params[:territory], params[:region],
      params[:firstName], params[:lastName]).page params[:page]
    #@people = Registration.find( {first_name: "Angel"});

    respond_to do |format|
    	format.html
    	format.csv { 
    		Rails.logger.debug( "Search params: #{params[:dealerAccount]}   ")
#    		@people = Registry.search(params[:fromDate],params[:toDate],params[:purchaseDate],
#				      params[:dealerAccount],params[:dealerName],params[:flagship], params[:model], params[:serialNumber], 
#				      params[:territory], params[:region],
#				      params[:firstName], params[:lastName]);
    		send_data @peoplenopage.to_csv }
    	# format.xls { send_data @people.to_csv(col_sep: "\t") }
    end
  end
end
