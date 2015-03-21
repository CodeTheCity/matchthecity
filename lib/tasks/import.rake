# encoding: utf-8
namespace :import do

  require 'csv'

  desc "Rebuild Data"
  task :rebuild_all => [:drop_data, :asv_classes_json, :asv_swimming_classes_json, :sport_events, :aquatics, :skills, :venues]

  desc "Drop data"
  task :drop_data => :environment do
    puts "Dropping all existing data"
    Opportunity.destroy_all
    Venue.destroy_all
    SubActivity.destroy_all
    Activity.destroy_all
    Skill.destroy_all
    Region.destroy_all
  end

  desc "Transition Extreme classes JSON"
  task :te_classes_json => :environment do
    puts "Importing Transition Extreme classes from JSON"

    data_path = File.expand_path("../../../data/transition_extreme.json", __FILE__)
    json = JSON.parse(IO.read(data_path))
    exercise_classes_json = json['classes']
    puts exercise_classes_json.count
    exercise_classes_json.each do |exercise_class_json|
      activity = exercise_class_json['activity']
      day_of_week = exercise_class_json['day_of_week']
      start_time = exercise_class_json['start_time']
      end_time = exercise_class_json['end_time']
      title = exercise_class_json['name']
      room = exercise_class_json['location']
      description = exercise_class_json['description']
      image_url = exercise_class_json['iconUrl']
      source_reference = exercise_class_json['source_ref']

      existing_activity = Activity.find_by_title(activity)
      if existing_activity.nil?
        existing_activity = Activity.new(:title => activity, :category => 'sport')
        existing_activity.save
      end

      existing_sub_activity = existing_activity.sub_activities.find_by_title(title)
      if existing_sub_activity.nil?
        existing_sub_activity = SubActivity.new(:title => title, :activity => existing_activity)
        existing_sub_activity.save
      end

      organisation = Organisation.find_by_name('Transition Extreme Sports')
      if organisation.nil?
        region = Region.find_by_name('Aberdeen')
        if region.nil?
          region = Region.create(:name => 'Aberdeen')
        end
        organisation = Organisation.new(:name => 'Transition Extreme Sports', :region => region)
        organisation.save
      end

      venue = Venue.find_by_name('Transition Extreme')
      if venue.nil?
        region = Region.find_by_name('Aberdeen')
        if region.nil?
          region = Region.create(:name => 'Aberdeen')
        end
        venue = Venue.new(:name => 'Transition Extreme', :region => region)
        venue.save
      end

      opportunity = Opportunity.find_by_source_reference("#{source_reference}")
      if opportunity.nil?
        opportunity = Opportunity.new(:source_reference => "#{source_reference}")
      end
      opportunity.name = title
      opportunity.category = 'Event'
      opportunity.activity = existing_activity
      opportunity.sub_activity = existing_sub_activity
      opportunity.venue = venue
      opportunity.room = room
      opportunity.description = "#{description}"
      opportunity.day_of_week = day_of_week
      opportunity.start_time = start_time
      opportunity.end_time = end_time
      opportunity.image_url = image_url
      opportunity.organisation = organisation
      opportunity.save

      tags_json = exercise_class_json['tag_list']
      tags_json.each do |tag|
        opportunity.tag_list.add(tag)
        opportunity.save
      end
    end
  end

  desc "Aberdeen Sports Village classes JSON"
  task :asv_classes_json => :environment do
    puts "Importing Aberdeen Sports Villages classes from JSON"

    tag_lookup = {}
    tag_lookup["strength"] = ["trxpress", "body attack", "body balance", "hit", "blt", "trx: core", "blt blast", "synrgy360 circuits", "learn-to-trx", "trx fitness", "circuits", "ultimate abs","kettlebells", "otago (strength & balance)"]
    tag_lookup["cardio"] = ["studio cycling blast", "body pump", "body combat", "total fitness", "bootcamp", "studio cycling", "body attack", "evergreens table tennis", "cardiac rehab", "well-being exercise", "zumba gold", "evergreens exercise", "hit", "evergreens swimming", "bokwa fitness", "aqua aerobics", "totally terrified", "evergreens aquafun", "aqua zumba", "studio cycling plus", "step", "blt", "blt blast", "zumba", "synrgy360 circuits", "circuits", "studio cycling blast", "sports conditioning", "boxfit", "jog scotland", "adult badminton", "sh'bam"]
    tag_lookup["weight loss"] = ["aqua circuits" ]
    tag_lookup["flexibility"] = ["fitness yoga", "yoga", "body balance", "evergreens fitness pilates", "stretching workshop"]

    data_path = File.expand_path("../../../data/asv_classes.json", __FILE__)
    json = JSON.parse(IO.read(data_path))
    count = json['count']
    puts "#{count} classes to import"
    exercise_classes_json = json['courseItemJSONDTOList']
    puts exercise_classes_json.count
    exercise_classes_json.each do |exercise_class_json|
      activity = 'Exercise Class'
      day_of_week = exercise_class_json['dow']
      start_time = exercise_class_json['startTime']
      end_time = exercise_class_json['endTime']
      title = exercise_class_json['name']
      room = exercise_class_json['location']
      description = exercise_class_json['desc']
      image_url = exercise_class_json['iconUrl']
      source_reference = exercise_class_json['id']

      existing_activity = Activity.find_by_title(activity)
      if existing_activity.nil?
        existing_activity = Activity.new(:title => activity, :category => 'sport')
        existing_activity.save
      end

      existing_sub_activity = SubActivity.find_by_title(title)
      if existing_sub_activity.nil?
        existing_sub_activity = SubActivity.new(:title => title, :activity => existing_activity)
        existing_sub_activity.save
      end

      organisation = Organisation.find_by_name('Aberdeen Sports Village')
      if organisation.nil?
        region = Region.find_by_name('Aberdeen')
        if region.nil?
          region = Region.create(:name => 'Aberdeen')
        end
        organisation = Organisation.new(:name => 'Aberdeen Sports Village', :region => region)
        organisation.save
      end

      venue = Venue.find_by_name('Aberdeen Sports Village')
      if venue.nil?
        region = Region.find_by_name('Aberdeen')
        if region.nil?
          region = Region.create(:name => 'Aberdeen')
        end
        venue = Venue.new(:name => 'Aberdeen Sports Village', :region => region)
        venue.save
      end

      opportunity = Opportunity.find_by_source_reference("#{source_reference}")
      if opportunity.nil?
        opportunity = Opportunity.new(:source_reference => "#{source_reference}")
      end
      opportunity.name = title
      opportunity.category = 'Event'
      opportunity.activity = existing_activity
      opportunity.sub_activity = existing_sub_activity
      opportunity.venue = venue
      opportunity.room = room
      opportunity.description = "#{description}"
      opportunity.day_of_week = day_of_week
      opportunity.start_time = start_time
      opportunity.end_time = end_time
      opportunity.image_url = image_url
      opportunity.organisation = organisation
      opportunity.save

      # Tag it if we can
      tag_lookup.keys.each do |key|
        titles = tag_lookup[key]
        if titles.include? opportunity.sub_activity.title.downcase
          puts "#{opportunity.sub_activity.title} is #{key}"
          opportunity.tag_list.add(key)
          opportunity.save
        end
      end
    end
  end

  desc "Aberdeen Sports Village swimmimg classes JSON"
  task :asv_swimming_classes_json => :environment do
    puts "Importing Aberdeen Sports Villages swimming classes from JSON"
    data_path = File.expand_path("../../../data/asv_swim_classes.json", __FILE__)
    json = JSON.parse(IO.read(data_path))
    count = json['count']
    puts "#{count} classes to import"
    exercise_classes_json = json['courseItemJSONDTOList']
    puts exercise_classes_json.count
    exercise_classes_json.each do |exercise_class_json|
      activity = 'Exercise Class'
      day_of_week = exercise_class_json['dow']
      start_time = exercise_class_json['startTime']
      end_time = exercise_class_json['endTime']
      title = exercise_class_json['name'].capitalize
      room = exercise_class_json['location']
      description = exercise_class_json['desc']
      image_url = exercise_class_json['iconUrl']
      source_reference = exercise_class_json['id']

      existing_activity = Activity.find_by_title(activity)
      if existing_activity.nil?
        existing_activity = Activity.new(:title => activity, :category => 'sport')
        existing_activity.save
      end

      existing_sub_activity = SubActivity.find_by_title(title)
      if existing_sub_activity.nil?
        existing_sub_activity = SubActivity.new(:title => title, :activity => existing_activity)
        existing_sub_activity.save
      end

      venue = Venue.find_by_name('Aberdeen Sports Village')
      if venue.nil?
        region = Region.find_by_name('Aberdeen')
        if region.nil?
          region = Region.create(:name => 'Aberdeen')
        end
        venue = Venue.new(:name => 'Aberdeen Sports Village', :region => region)
        venue.save
      end

      opportunity = Opportunity.find_by_source_reference("#{source_reference}")
      if opportunity.nil?
        opportunity = Opportunity.new(:source_reference => "#{source_reference}")
      end
      opportunity.name = title
      opportunity.category = 'Event'
      opportunity.activity = existing_activity
      opportunity.sub_activity = existing_sub_activity
      opportunity.venue = venue
      opportunity.room = room
      opportunity.description = "#{description}"
      opportunity.day_of_week = day_of_week
      opportunity.start_time = start_time
      opportunity.end_time = end_time
      opportunity.image_url = image_url
      opportunity.save
    end
  end

  desc "Import Venues"
  task :venues => :environment do
    started_at = Time.now

    puts "Importing Venues starting at #{started_at}"
    data_path = File.expand_path("../../../data/venues.json", __FILE__)
    json = JSON.parse(IO.read(data_path))

    features_json = json['features']

    features_json.each do |feature_json|
      venue_json = feature_json['properties']
      venue_json['name']
      venue = Venue.where('lower(name) = ?', venue_json['name'].downcase).first
      if venue.nil?
        region = Region.find_by_name('Aberdeen')
        if region.nil?
          region = Region.create(:name => 'Aberdeen')
        end
        venue = Venue.new(:name => venue_json['name'], :region => region)
      end

      owner_name = venue_json['owner']
      owner = VenueOwner.where('lower(name) = ?', owner_name.downcase).first
      if owner.nil?
        region = Region.find_by_name('Aberdeen')
        if region.nil?
          region = Region.create(:name => 'Aberdeen')
        end
        owner = VenueOwner.new(:name => owner_name, :region => region)
      end
      owner.save

      venue.venue_owner = owner

      venue.address = venue_json['address']
      venue.postcode = venue_json['postcode']
      venue.latitude = venue_json['lat']
      venue.longitude = venue_json['long']
      venue.telephone = venue_json['tel']
      venue.email = venue_json['email']
      venue.web = venue_json['web']
      venue.save

      venue_notices_json = venue_json['venue_notices']
      unless venue_notices_json.nil?
        venue_notices_json.each do |venue_notice_json|
          notice_start = venue_notice_json['start']
          notice_expires = venue_notice_json['expires']
          notice_message = venue_notice_json['message']
          venue_notice = venue.venue_notices.where('starts = ?', notice_start.to_datetime).first
          if venue_notice.nil?
            venue_notice = VenueNotice.new(:venue => venue, :starts => notice_start.to_datetime)
          end
          venue_notice.expires = notice_expires.to_datetime unless notice_expires.nil?
          venue_notice.message = notice_message
          venue_notice.save
        end
      end
    end
  end

  desc "Import Aberdeen Sports Events"
  task :sport_events => :environment do
    started_at = Time.now

    data_path = File.expand_path("../../../data/sport_events.json", __FILE__)
    json = JSON.parse(IO.read(data_path))


=begin
{
    "name": "Public  Lane Session (2 lanes)",
    "activity": "Swimming",
    "venue": "Bucksburn Swimming Pool",
    "day": "Monday",
    "start": "07:00",
    "end": "09:00",
    "description": "Laned Swimming Session.",
    "time_of_year": "Term Time Only",
    "age": "",
    "age_group": "ALL"
  }
=end
    count = 0
    failed = 0
    total = json.count

    json.each do |event_json|
      count = count + 1

      activity = event_json['activity'].capitalize
      day_of_week = event_json['day']
      start_time = event_json['start']
      end_time = event_json['end']
      title = event_json['name'].capitalize
      room = ''
      description = event_json['description']
      venue_name = event_json['venue']

      existing_activity = Activity.find_by_title(activity)
      if existing_activity.nil?
        existing_activity = Activity.new(:title => activity, :category => 'sport')
        existing_activity.save
      end

      existing_sub_activity = SubActivity.find_by_title(title)
      if existing_sub_activity.nil?
        existing_sub_activity = SubActivity.new(:title => title, :activity => existing_activity)
        existing_sub_activity.save
      end

      venue = Venue.find_by_name(venue_name)
      if venue.nil?
        region = Region.find_by_name('Aberdeen')
        if region.nil?
          region = Region.create(:name => 'Aberdeen')
        end
        venue = Venue.new(:name => venue_name, :region => region)
        venue.save
      end

      opportunity = Opportunity.new(:name => "#{title}",
        :category => 'Event',
        :activity => existing_activity,
        :sub_activity => existing_sub_activity,
        :venue => venue,
        :room => room,
        :description => "#{description}",
        :day_of_week => day_of_week,
        :start_time => start_time,
        :end_time => end_time)
      opportunity.save
    end

    completed_at = Time.now
    puts "Import started #{started_at} completed at #{completed_at}"
    puts "#{failed} out of #{total} failed to import"
  end

  desc "Import RGU Sport classes"
  task :rgu_sport_classes => :environment do
    started_at = Time.now

    puts "Importing RGU Sport classes starting at #{started_at}"
    data_path = File.expand_path("../../../data/rgu_sport.csv", __FILE__)
    rows_to_import = CSV.read(data_path, :col_sep => ",", :headers => true)
    total = rows_to_import.count
    puts "#{total} rows to import"

    # Class,Day,Time,Studio,Type
    count = 0
    failed = 0

    rows_to_import.each do |row|
      count = count + 1

      activity = 'Exercise Class'
      title = row[0]
      day_of_week = row[1]
      time = row[2]
      start_time = time.split(' - ').first.insert(2, ':')
      end_time = time.split(' - ').last.insert(2, ':')
      room = row[3]
      tags = row[4]

      source_reference = "#{title}:#{day_of_week}:#{time}"

      existing_activity = Activity.find_by_title(activity)
      if existing_activity.nil?
        existing_activity = Activity.new(:title => activity, :category => 'sport')
        existing_activity.save
      end

      existing_sub_activity = SubActivity.find_by_title(title)
      if existing_sub_activity.nil?
        existing_sub_activity = SubActivity.new(:title => title, :activity => existing_activity)
        existing_sub_activity.save
      end

      venue = Venue.find_by_name('RGU Sport')
      if venue.nil?
        region = Region.find_by_name('Aberdeen')
        if region.nil?
          region = Region.create(:name => 'Aberdeen')
        end
        venue = Venue.new(:name => 'RGU Sport', :region => region)
        venue.save
      end

      opportunity = Opportunity.find_by_source_reference("#{source_reference}")
      if opportunity.nil?
        opportunity = Opportunity.new(:source_reference => "#{source_reference}")
      end
      opportunity.name = title
      opportunity.category = 'Event'
      opportunity.activity = existing_activity
      opportunity.sub_activity = existing_sub_activity
      opportunity.venue = venue
      opportunity.room = room
      opportunity.day_of_week = day_of_week
      opportunity.start_time = start_time
      opportunity.end_time = end_time
      opportunity.description = ""
      opportunity.save

      tags.split('/').each do |tag|
        opportunity.tag_list.add(tag.downcase)
        opportunity.save
      end
    end

    completed_at = Time.now
    puts "Import started #{started_at} completed at #{completed_at}"
    puts "#{failed} out of #{total} failed to import"

  end


  desc "Import Aberdeen Sports Village Activities"
  task :asv_sport_activities => :environment do
    started_at = Time.now

    puts "Importing Aberdeen Sports Village activities starting at #{started_at}"
    data_path = File.expand_path("../../../data/ASV_Exercise_classes_140622.csv", __FILE__)
    rows_to_import = CSV.read(data_path, :col_sep => "$", :headers => true)
    total = rows_to_import.count
    puts "#{total} rows to import"

    # Day_of_week$Start_Time$End_Time$Name$Location$Description


    count = 0
    failed = 0

    rows_to_import.each do |row|
      count = count + 1

      activity = 'Exercise Class'
      day_of_week = row[0]
      start_time = row[1]
      end_time = row[2]
      title = row[3]
      room = row[4]
      description = row[5]

      existing_activity = Activity.find_by_title(activity)
      if existing_activity.nil?
        existing_activity = Activity.new(:title => activity, :category => 'sport')
        existing_activity.save
      end

      existing_sub_activity = SubActivity.find_by_title(title)
      if existing_sub_activity.nil?
        existing_sub_activity = SubActivity.new(:title => title, :activity => existing_activity)
        existing_sub_activity.save
      end

      venue = Venue.find_by_name('Aberdeen Sports Village')
      if venue.nil?
        region = Region.find_by_name('Aberdeen')
        if region.nil?
          region = Region.create(:name => 'Aberdeen')
        end
        venue = Venue.new(:name => 'Aberdeen Sports Village', :region => region)
        venue.save
      end

      opportunity = Opportunity.new(:name => "#{title}",
        :category => 'Event',
        :activity => existing_activity,
        :sub_activity => existing_sub_activity,
        :venue => venue,
        :room => room,
        :description => "#{description}",
        :day_of_week => day_of_week,
        :start_time => start_time,
        :end_time => end_time)
      opportunity.save
    end

    completed_at = Time.now
    puts "Import started #{started_at} completed at #{completed_at}"
    puts "#{failed} out of #{total} failed to import"
  end

  desc "Import Aberdeen Aquatics Centre Activities"
  task :aquatics => :environment do

    data_path = File.expand_path("../../../data/aquaticscentreactivities.xml", __FILE__)
    doc = Nokogiri::XML(File.open(data_path))

    root = doc.root
    items = root.xpath("activity")
    items.each do |item|
      activity = Hash.new
      activity['dayofWeek'] = item.at('dayofWeek').text
      activity['startTime'] = item.at('startTime').text
      activity['endTime'] = item.at('endTime').text
      description = item.at('description').text
      description = "Swimming" if description == "Public Swimming"
      subdescription = item.at('subdescription').text
      if subdescription == ""
        subdescription = description
        description = "Swimming"
      end
      activity['description'] = description
      activity['subdescription'] = subdescription
      #activity['poolLength'] = item.at('poolLength').text

      existing_activity = Activity.find_by_title(description)
      if existing_activity.nil?
        existing_activity = Activity.new(:title => description, :category => 'sport')
        existing_activity.save
      end

      existing_sub_activity = SubActivity.find_by_title(subdescription)
      if existing_sub_activity.nil?
        existing_sub_activity = SubActivity.new(:title => subdescription, :activity => existing_activity)
        existing_sub_activity.save
      end

      venue = Venue.find_by_name('Aberdeen Sports Village')
      if venue.nil?
        region = Region.find_by_name('Aberdeen')
        if region.nil?
          region = Region.create(:name => 'Aberdeen')
        end
        venue = Venue.new(:name => 'Aberdeen Sports Village', :region => region)
        venue.save
      end

      opportunity = Opportunity.new(:name => "#{description} - #{subdescription}",
        :category => 'Event',
        :activity => existing_activity,
        :sub_activity => existing_sub_activity,
        :venue => venue,
        :description => "",
        :day_of_week => activity['dayofWeek'],
        :start_time => activity['startTime'],
        :end_time => activity['endTime'])
      opportunity.save


    end
  end


  desc "Import Soft Skills"
  task :skills => :environment do
    started_at = Time.now

    puts "Importing soft skills starting at #{started_at}"
    data_path = File.expand_path("../../../data/softskills.txt", __FILE__)
    rows_to_import = CSV.read(data_path, :col_sep => " ", :headers => false)
    total = rows_to_import.count
    puts "#{total} rows to import"

    count = 0
    failed = 0

    rows_to_import.each do |row|
      count = count + 1

      title = row[0]

      skill = Skill.find_by_title(title)
      if skill.nil?
        skill = Skill.new(:title => title)
        skill.save
      end


      unless skill.valid?
        failed = failed + 1
        puts skill.errors.full_messages
      end
    end

    completed_at = Time.now
    puts "Import started #{started_at} completed at #{completed_at}"
    puts "#{failed} out of #{total} failed to import"
  end


  desc "Import Sport Activities"
  task :sport_activities => :environment do
    started_at = Time.now

    puts "Importing sport activities starting at #{started_at}"
    data_path = File.expand_path("../../../data/sports.txt", __FILE__)
    rows_to_import = CSV.read(data_path, :col_sep => " ", :headers => false)
    total = rows_to_import.count
    puts "#{total} rows to import"

    count = 0
    failed = 0

    rows_to_import.each do |row|
      count = count + 1

      title = row[0]

      activity = Activity.find_by_title(title)
      if activity.nil?
        activity = Activity.new(:title => title, :category => 'sport')
        activity.save
      end


      unless activity.valid?
        failed = failed + 1
        puts activity.errors.full_messages
      end
    end

    completed_at = Time.now
    puts "Import started #{started_at} completed at #{completed_at}"
    puts "#{failed} out of #{total} failed to import"
  end
end