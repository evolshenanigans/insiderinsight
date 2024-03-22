require 'puppeteer'
require 'nokogiri'

class OfficialsScraper
  URL = 'https://www.capitoltrades.com/trades?txDate=30d&per_page=96'

  def self.scrape
    Puppeteer.launch(headless: true) do |browser|
      page = browser.new_page
      page.goto(URL, wait_until: 'networkidle0')
      html_content = page.content
      doc = Nokogiri::HTML(html_content)

      doc.css('tr.q-tr').each do |row|
        politician_name = row.at_css('.politician-name a').text.strip rescue nil
        party = row.at_css('.party').text.strip rescue nil
        state = row.at_css('.us-state-compact').text.strip rescue nil
        stock_name = row.at_css('.issuer-name a').text.strip rescue nil

        next unless politician_name && party && state && stock_name

        # Find or create the official by name
        official = Official.find_or_create_by(name: politician_name) do |o|
          o.party_affiliation = party
          o.state = state
        end

        # Associate stock with the official
        official.stocks.find_or_create_by(name: stock_name)

        puts "Processed: #{politician_name}, Party: #{party}, State: #{state}, Stock: #{stock_name}"
      end
    end
  end
end

OfficialsScraper.scrape
