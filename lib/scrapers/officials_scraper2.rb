# unused file?
require 'puppeteer'
require 'nokogiri'
require 'csv'
require 'date'
require 'pg'

# Scraper class to fetch and store data about government officials' trades from a specific website.
class OfficialsScraper
  # URL to scrape the data from, filtered for transactions within the last 30 days.
  URL = 'https://www.capitoltrades.com/trades?txDate=30d&per_page=96'

  # Main method to launch the scraper process.
  def self.scrape
    Puppeteer.launch(headless: true) do |browser|
      page = browser.new_page
      page.goto(URL, wait_until: 'networkidle0')
      html_content = page.content
      doc = Nokogiri::HTML(html_content)

      # Opening CSV files to store scraped data.
      CSV.open("officials.csv", "wb") do |officials_csv|
        CSV.open("stocks.csv", "wb") do |stocks_csv|
          CSV.open("trades.csv", "wb") do |trades_csv|
            # Define headers for each CSV file.
            officials_csv << ["name", "party_affiliation", "state", "image_url", "created_at", "updated_at"]
            stocks_csv << ["name"]
            trades_csv << ["official_id", "stock_id", "transaction_type", "transaction_count", "security_type"]

            # Iterate over each trade row in the HTML.
            doc.css('tr.q-tr').each do |row|
              # Extract data from HTML using CSS selectors.
              politician_name = row.at_css('.politician-name a').text.strip rescue nil
              party = row.at_css('.party').text.strip rescue nil
              state = row.at_css('.us-state-compact').text.strip rescue nil
              volume = row.at_css('.cell--volume .q-value').text.strip.gsub(/[^\d]/, '') rescue nil
              stock_name = row.at_css('.issuer-name a').text.strip rescue nil
              transaction_type = row.at_css('.tx-type').text.strip rescue nil
              security_type = row.at_css('.security-type').text.strip rescue nil
              image_url = "URL_TO_IMAGE" # Placeholder for image URL extraction logic
              current_time = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')

              # Write extracted data to CSV files.
              officials_csv << [politician_name, party, state, image_url, current_time, current_time]
              stocks_csv << [stock_name]
              trades_csv << [1, 1, transaction_type, volume, security_type]  # Example IDs
            end
          end
        end
      end
    end
  end
end

# Utility function to copy CSV data to a PostgreSQL database.
def copy_csv_to_database(csv_file_path, table_name, columns)
  conn = PG.connect(dbname: 'insiderinsight', user: 'insiderinsight', password: '', host: '')
  copy_command = "COPY #{table_name}(#{columns.join(',')}) FROM '#{csv_file_path}' DELIMITER ',' CSV HEADER;"
  conn.exec(copy_command)
rescue PG::Error => e
  puts e.message
ensure
  conn&.close  # Ensure connection closure on method exit.
end

# Start the scraping process.
OfficialsScraper.scrape
