# encoding: utf-8
namespace :import_edinburgh do

  require 'csv'

  desc "Import Sports and Recreational Facilities"
  task :sports_and_recs => :environment do

    conn = Faraday.new(:url => 'http://www.edinburghopendata.info') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    ## GET ##

    response = conn.get 'dataset/2d3a98c8-7584-4647-b5f2-62f8eb57d889/resource/b31e2bd8-b933-4adb-9b53-0d6b0a3b6832/download/sportsandrecreationalfacilities.csv'     # GET http://www.edinburghopendata.info/dataset/2d3a98c8-7584-4647-b5f2-62f8eb57d889/resource/b31e2bd8-b933-4adb-9b53-0d6b0a3b6832/download/sportsandrecreationalfacilities.csv
    venues = response.body


    # Name,Address,Postcode,Telephone,Email,"Opening hours",Facilities,Activities,Prices,Timetables,"More information",Location

    rows_to_import = CSV.parse(venues)
    total = rows_to_import.count
    puts "#{total} rows to import"


    arr_of_arrs = CSV.parse(venues)
    puts "Array rows #{arr_of_arrs.count}"

    count = 0
    arr_of_arrs.each do |row|
      count = count + 1

      if count > 1
        venue = Venue.where('lower(name) = ?', row[0].downcase).first
        if venue.nil?
          region = Region.find_by_name('Edinburgh')
          if region.nil?
            region = Region.create(:name => 'Edinburgh')
          end
          venue = Venue.new(:name => row[0], :region => region)
        end

        venue.address = row[1]
        venue.postcode = row[2]
        location = row[11]
        unless location.nil?
          venue.latitude = row[11].split.first
          venue.longitude = row[11].split.last
        end
        venue.telephone = row[3]
        venue.email = row[4]
        #venue.web = venue_json['web']
        venue.save
      end
    end
  end
end