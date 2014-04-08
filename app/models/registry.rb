class Registry
  include Mongoid::Document

  store_in collection: "registrations"

  field :first_name, type: String
  field :last_name, type:String
  field :dealer_account, type:String
  field :dealer_store, type:String
  field :region, type:String
  field :territory, type:String
  field :flagship, type:String
  field :purchase_date, type:DateTime
  field :registered_date, type:DateTime
  field :products, type:Array


  def self.search(fromDate,toDate,purchaseDate,dealerAccount,dealerName,flagship,
                  model,serial,territory,region,firstName,lastName)

  	unless fromDate.present? || toDate.present? || purchaseDate.present? || dealerAccount.present? || 
      dealerName.present? || flagship.present? || model.present? || serial.present? || 
      territory.present? || region.present? || firstName.present? || lastName.present?
  		Registry.all;
  	else
  		query = {};
  		
  		if (fromDate.present? || toDate.present? )
  			params = {}
  			if (fromDate.present?)
          list = "#{fromDate}".split("/")
  				params[:$gte] = list[2] + '-' + list[0] +'-'+ list[1]
  			end
  			if (toDate.present?)
          list = "#{toDate}".split("/")
  				params[:$lte] = list[2] + '-' + list[0] +'-'+ list[1]
  			end  	
  			query[:registered_date] = params		
  		end
  		if (purchaseDate.present? )
        list = "#{purchaseDate}".split("/")
  			query[:purchase_date] = list[2] + '-' + list[0] +'-'+ list[1]
  		end
      if (dealerAccount.present?)
        regex = {}
        mod = {}
        ele = {}
        regex[:$regex] = "#{dealerAccount}"
        regex[:$options] = 'i'
        query[:dealer_account] = regex
      end      
  		if (dealerName.present?)
        regex = {}
        mod = {}
        ele = {}
        regex[:$regex] = "#{dealerName}"
        regex[:$options] = 'i'
  			query[:dealer_store] = regex
  		end
  		if (flagship.present?)
  			query[:flagship] = "#{flagship}"
  		end
  		if (model.present?)
  			regex = {}
  			mod = {}
  			ele = {}
  			regex[:$regex] = "#{model}"
  			regex[:$options] = 'i'
  			mod[:model] = regex
  			ele[:$elemMatch] = mod
  			query[:products] = ele
  		end
  		if (serial.present?)
  			regex = {}
  			mod = {}
  			ele = {}
  			regex[:$regex] = "#{serial}"
  			regex[:$options] = 'i'
  			mod[:serial] = regex
  			ele[:$elemMatch] = mod
  			query[:products] = ele
  		end
      if (territory.present?)
        query[:territory] = "#{territory}"
      end
      if (region.present?)
        query[:region] = "#{region}"
      end
  		if (firstName.present?)
        regex = {}
        mod = {}
        ele = {}
        regex[:$regex] = "#{firstName}"
        regex[:$options] = 'i'        
  			query[:first_name] = regex
  		end
  		if (lastName.present?)
        regex = {}
        mod = {}
        ele = {}
        regex[:$regex] = "#{lastName}"
        regex[:$options] = 'i'                
  			query[:last_name] = regex
  		end

	  	Registry.where(query)
  	end
  end

    def self.to_csv(options ={})
      CSV.generate(options) do |csv|
#        csv << column_names
        column_names = ["Dealer Account", "Dealer", "Region", "Territory", "Warranty (Years)", 
          "Purchase Date","Register Date", 'Model', 'Serial Number', 'First Name', 'Last Name']
        mongo_column_names1 = ['dealer_account', 'purchase_date']
        mongo_column_names2 = ['first_name', 'last_name']
        # record = Array.new
        csv << column_names
#        csv << %w['Dealer Account' 'Purchase Date' 'Model' 'Serial Number' 'First Name' 'Last Name']
        all.each do |person|
          person.products.each do |product|
            record = Array.new
            temp = person.attributes.values_at('dealer_account')[0]
            record.push(temp);
            temp = person.attributes.values_at('dealer_store')[0]
            record.push(temp);
            temp = person.attributes.values_at('region')[0]
            record.push(temp);
            temp = person.attributes.values_at('territory')[0]
            record.push(temp);
            if (person.attributes.values_at('fs')[0] == 'FS')
              record.push(2);
            else
              record.push(1)
            end
            temp = person.attributes.values_at('purchase_date')[0].strftime("%m/%d/%Y")
            record.push(temp);
            temp = person.attributes.values_at('registered_date')[0].strftime("%m/%d/%Y")
            record.push(temp);
            temp = product.values_at('model')[0]
            record.push(temp);
            temp = product.values_at('serial')[0]
            record.push(temp);
            temp = person.attributes.values_at('first_name')[0]
            record.push(temp);
            temp = person.attributes.values_at('last_name')[0]
            record.push(temp);

#            record.push(product.values_at('model').to_s)
#            record.push(product.values_at('serial').to_s)
 #           record += ' ';
 #           record << person.attributes.values_at(*mongo_column_names2).to_s
#            csv << person.products.model
#            csv << person.dealer_account, person.purchase_date, product.model, product.serial, person.first_name, person.last_name
          csv << record
          end
        end
      end
    end

end
