namespace :scrape_load do
  desc 'Run All'
  task all: %i[hidive gothic newman larimer hq mission bluebird globe_hall lost_lake]

  desc 'scrape hidive for events'
  task hidive: :environment do
    shows = ShowBuilderService.build_shows(HidiveScraper)
    if shows.empty?
      puts 'No Hi-Dive events to scrape.'
    else
      puts "Successfully scraped #{shows.count} Hi-Dive events"
    end
  end
  desc 'scrape gothic theater for events'
  task gothic: :environment do
    shows = ShowBuilderService.build_shows(GothicScraper)
    if shows.empty?
      puts 'No Gothic Center events to scrape.'
    else
      puts "Successfully scraped #{shows.count} Gothic Center events"
    end
  end
  desc 'scrape gothic theater for events'
  task newman: :environment do
    shows = ShowBuilderService.build_shows(NewmanScraper)
    if shows.empty?
      puts 'No Newman Center events to scrape.'
    else
      puts "Successfully scraped #{shows.count} Newman Center events"
    end
  end
  desc 'scrape gothic theater for events'
  task larimer: :environment do
    shows = ShowBuilderService.build_shows(LarimerScraper)
    if shows.empty?
      puts 'No Larimer events to scrape.'
    else
      puts "Successfully scraped #{shows.count} Larimer events"
    end
  end
  desc 'scrape gothic theater for events'
  task hq: :environment do
    shows = ShowBuilderService.build_shows(HqScraper)
    if shows.empty?
      puts 'No HQ events to scrape.'
    else
      puts "Successfully scraped #{shows.count} HQ events"
    end
  end
  desc 'scrape gothic theater for events'
  task mission: :environment do
    shows = ShowBuilderService.build_shows(MissionScraper)
    if shows.empty?
      puts 'No Mission Ballroom events to scrape.'
    else
      puts "Successfully scraped #{shows.count} Mission Ballroom events"
    end
  end
  desc 'scrape gothic theater for events'
  task bluebird: :environment do
    shows = ShowBuilderService.build_shows(BluebirdScraper)
    if shows.empty?
      puts 'No BlueBird Theater events to scrape.'
    else
      puts "Successfully scraped #{shows.count} Gothic Theater events"
    end
  end
  desc 'scrape oriental theater for evetns'
  task oriental: :environment do
    shows = ShowBuilderService.build_shows(OrientalScraper)
    if shows.empty?
      puts 'No Oriental Theater events to scrape.'
    else
      puts "Successfully scraped #{shows.count} Oriental Theater events"
    end
  end
  desc 'scrape lost lake for evetns'
  task lost_lake: :environment do
    shows = ShowBuilderService.build_shows(LostLakeScraper)
    if shows.empty?
      puts 'No lost lake events to scrape.'
    else
      puts "Successfully scraped #{shows.count} lost lake events"
    end
  end
  desc 'scrape lost lake for evetns'
  task globe_hall: :environment do
    shows = ShowBuilderService.build_shows(GlobeHallScraper)
    if shows.empty?
      puts 'No Glob Hall events to scrape.'
    else
      puts "Successfully scraped #{shows.count} Glob Hall events"
    end
  end
  desc 'scrape skylark for evetns'
  task skylark: :environment do
    shows = ShowBuilderService.build_shows(SkylarkScraper)
    if shows.empty?
      puts 'No Skylark events to scrape.'
    else
      puts "Successfully scraped #{shows.count} Skylark events"
    end
  end
  desc 'Reset all Primary Keys'
  task reset_pks: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end
