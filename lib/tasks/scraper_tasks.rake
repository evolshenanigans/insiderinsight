# lib/tasks/scraper_tasks.rake
namespace :scraper do
  desc "Scrape officials data"
  task scrape_officials: :environment do
    require_relative '../../lib/scrapers/officials_scraper'
    OfficialsScraper.scrape
  end
end
