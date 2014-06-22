# encoding: utf-8
namespace :import do

  require 'csv'

  desc "Import Aquatics"
  task :aquatics => :environment do

    data_path = File.expand_path("../../../data/aquaticscentreactivities.xml", __FILE__)
    doc = Nokogiri::XML(File.open(data_path))

    activities = []
    root = doc.root
    items = root.xpath("activity")
    items.each do |item|
      activity = Hash.new
      #activity['dayofWeek'] = item.at('dayofWeek').text
      #activity['startTime'] = item.at('startTime').text
      #activity['endTime'] = item.at('endTime').text
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
        existing_activity = Activity.new(:title => title, :category => 'sport')
        existing_activity.save
      end

      existing_sub_activity = SubActivity.find_by_title(subdescription)
      if existing_sub_activity.nil?
        existing_sub_activity = SubActivity.new(:title => subdescription, :activity => existing_activity)
        existing_sub_activity.save
      end
      activities << activity
    end

    puts activities
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