class ShowBuilderService
  def self.build
    build_mission
    build_bluebird
    build_gothic
    build_larimer
    build_hq
    build_hidive
    build_newman
  end

  def self.build_shows(venue)
    venue.shows.map do |show|
      Show.find_or_create_by(show)
    end
  end

  def self.build_bluebird
    BluebirdScraper.shows.map do |show|
      Show.find_or_create_by(show)
    end
  end

  def self.build_mission
    MissionScraper.shows.map do |show|
      Show.find_or_create_by(show)
    end
  end

  def self.build_gothic
    GothicScraper.shows.map do |show|
      Show.find_or_create_by(show)
    end
  end

  def self.build_hidive
    HidiveScraper.shows.map do |show|
      Show.find_or_create_by(show)
    end
  end

  def self.build_newman
    NewmanScraper.shows.map do |show|
      Show.find_or_create_by(show)
    end
  end

  def self.build_larimer
    LarimerScraper.shows.map do |show|
      Show.find_or_create_by(show)
    end
  end

  def self.build_hq
    HqScraper.shows.map do |show|
      Show.find_or_create_by(show)
    end
  end
end
