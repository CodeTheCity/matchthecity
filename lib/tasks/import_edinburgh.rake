# encoding: utf-8
namespace :import_edinburgh do

  require 'csv'

  desc "Import Edinburgh Leisure Classes"
  task :leisure_classes => :environment do

    # The following is for getting lat and long from address
    connNominatim = Faraday.new(:url => 'http://nominatim.openstreetmap.org') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    conn = Faraday.new(:url => 'http://www.edinburghopendata.info') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    ## GET ##

    response = conn.get 'dataset/a52988fa-5881-42c4-9bf6-c75ee19f0be5/resource/9d96cac9-14b5-4378-81fd-8d6c73492a53/download/edinburghleisuresites.csv'     # GET http://www.edinburghopendata.info/dataset/a52988fa-5881-42c4-9bf6-c75ee19f0be5/resource/9d96cac9-14b5-4378-81fd-8d6c73492a53/download/edinburghleisuresites.csv
    sites = response.body

    response = conn.get 'dataset/a52988fa-5881-42c4-9bf6-c75ee19f0be5/resource/3832facb-fcb6-4fc6-8809-9719ae8b715d/download/edinburghleisureactivities.csv'     # GET http://www.edinburghopendata.info/dataset/a52988fa-5881-42c4-9bf6-c75ee19f0be5/resource/3832facb-fcb6-4fc6-8809-9719ae8b715d/download/edinburghleisureactivities.csv
    activities = response.body

    response = conn.get 'dataset/a52988fa-5881-42c4-9bf6-c75ee19f0be5/resource/ba48b36b-e7b6-430c-82c3-a0e5f7ce2d54/download/edinburghleisureclasses.csv'     # GET http://www.edinburghopendata.info/dataset/a52988fa-5881-42c4-9bf6-c75ee19f0be5/resource/ba48b36b-e7b6-430c-82c3-a0e5f7ce2d54/download/edinburghleisureclasses.csv
    leisure_classes = response.body

    leisure_classes = leisure_classes.encode(invalid: :replace, undef: :replace, replace: '')
    activities = activities.encode(invalid: :replace, undef: :replace, replace: '')

    #leisure_classes.force_encoding('utf-8')
    sites_array = CSV.parse(sites)
    activities_array = CSV.parse(activities)
    leisure_classes_array = CSV.parse(leisure_classes)
=begin
    puts ">>>>"
    puts sites_array.first
    puts ">>>>"
    puts activities_array.first
    puts ">>>>"
    puts leisure_classes_array.first
    puts ">>>>"
=end

=begin
0 Site ID
1 Site Name
2 Address 1
3 Address 2
4 City
5 Postcode
6 Phone
7 Email
=end
    sites_array.each_with_index do |row, index|
      if index > 0

        venue = Venue.find_by_source_reference(row[0])
        if venue.nil?
          region = Region.find_by_name(row[4])
          if region.nil?
            region = Region.create(:name => row[4])
          end
          venue = Venue.new(:source_reference => row[0], :region => region)
        end

        venue.name = row[1]
        venue.address = "#{row[2]} #{row[3]} #{row[4]}"
        venue.postcode = row[5]


        response = connNominatim.get "search.php?q=#{URI::encode("#{row[2]}, #{row[3]}, #{row[4]}, #{row[5]}")}&format=json"

        json = JSON.parse(response.body)
        if json.first
          lat = json.first['lat']
          long = json.first['lon']
        else
          lat = ""
          long = ""
        end

        venue.latitude = lat
        venue.longitude = long
        venue.telephone = row[6]
        venue.email = row[7]
        #venue.web = venue_json['web']
        venue.save
      end
    end

    activities = Hash.new
    activities_array.each_with_index do |row, index|
      if index > 0
        activities[row[0]] = row[1]
      end
    end

=begin
0 Description
1 ID
2 Activity Group
3 Site
4 Start Time
5 Duration
6 Max Bookees
7 Min Bookees
8 Waiting List
9 Frequency
10 Sunday
11 Monday
12 Tuesday
13 Wednesday
14 Thursday
15 Friday
16 Saturday
17 Start Date
18 End Date
19 Web Bookable
20 Web Comments

=end

  days_of_week =%w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
  total_classes = leisure_classes_array.count
    leisure_classes_array.each_with_index do |row, index|
      puts "Importing #{index} of #{total_classes}" if index % 100 == 0
      if index > 0
        opportunity = Opportunity.find_by_source_reference(row[1])

        if opportunity.nil?
          opportunity = Opportunity.new(:source_reference => row[1])
        end

        days_of_week.each_with_index do |day, index|
          if row[index + 10] == "1"
            opportunity.day_of_week = day
            break
          end
        end

        opportunity.name = row[0]

        activity = 'Leisure Class'
        activity_group = activities[row[2]]
        existing_activity = Activity.find_by_title(activity)
        if existing_activity.nil?
          existing_activity = Activity.new(:title => activity, :category => 'sport')
          existing_activity.save
        end

        existing_sub_activity = SubActivity.find_by_title(activity_group)
        if existing_sub_activity.nil?
          existing_sub_activity = SubActivity.new(:title => activity_group, :activity => existing_activity)
          existing_sub_activity.save
        end

        venue = Venue.find_by_source_reference(row[3])

        opportunity.category = 'Event'
        start_time = Time.parse(row[4])
        end_time = start_time + row[5].to_i.minutes
        opportunity.start_time = "#{'%02i' % start_time.hour}:#{'%02i' % start_time.min}"
        opportunity.end_time = "#{'%02i' % end_time.hour}:#{'%02i' % end_time.min}"
        opportunity.description = row[20]
        opportunity.activity = existing_activity
        opportunity.sub_activity = existing_sub_activity
        opportunity.venue = venue

        opportunity.save
      end
    end
  end

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
          venue.latitude = row[11].split(",").first
          venue.longitude = row[11].split(",").last
        end
        venue.telephone = row[3]
        venue.email = row[4]
        #venue.web = venue_json['web']
        venue.save
      end
    end
  end
end