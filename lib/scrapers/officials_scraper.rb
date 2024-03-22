require 'puppeteer'
require 'nokogiri'

class OfficialsScraper
  URL = 'https://www.capitoltrades.com/trades?txDate=30d&per_page=96'

  def self.scrape
    Puppeteer.launch(headless: true) do |browser|
      page = browser.new_page
      page.goto(URL, wait_until: 'networkidle0')

      # Get the page HTML after JavaScript has rendered
      html_content = page.content

      # Parse the HTML with Nokogiri
      doc = Nokogiri::HTML(html_content)

      # Your existing Nokogiri parsing code here
      doc.css('tr.q-tr').each do |row|
        politician_name = row.at_css('.politician-name a').text.strip rescue "Not found"
        party = row.at_css('.party').text.strip rescue "Not found"
        state = row.at_css('.us-state-compact').text.strip rescue "Not found"
        stock_name = row.at_css('.issuer-name a').text.strip rescue "Not found"
        # Extract other data as before

        puts "Politician: #{politician_name}, Party: #{party}, State: #{state}, Stock: #{stock_name}"
      end
    end
  end
end

OfficialsScraper.scrape
