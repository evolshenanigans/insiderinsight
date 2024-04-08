require 'puppeteer'
require 'nokogiri'
require 'csv'
require 'date'
require 'pg'

class OfficialsScraper
  URL = 'https://www.capitoltrades.com/trades?txDate=30d&per_page=96'

  def self.scrape
    Puppeteer.launch(headless: true) do |browser|
      page = browser.new_page
      page.goto(URL, wait_until: 'networkidle0')
      html_content = page.content
      doc = Nokogiri::HTML(html_content)

      CSV.open("officials.csv", "wb") do |officials_csv|
        CSV.open("stocks.csv", "wb") do |stocks_csv|
          CSV.open("trades.csv", "wb") do |trades_csv|
            # Write headers only once
            officials_csv << ["name", "party_affiliation", "state", "image_url", "created_at", "updated_at"]
            stocks_csv << ["name"]
            trades_csv << ["official_id", "stock_id", "transaction_type", "transaction_count", "security_type"]

            doc.css('tr.q-tr').each do |row|
              # Extract and write data
              politician_name = row.at_css('.politician-name a').text.strip rescue nil
              party = row.at_css('.party').text.strip rescue nil
              state = row.at_css('.us-state-compact').text.strip rescue nil
              volume = row.at_css('.cell--volume .q-value').text.strip.gsub(/[^\d]/, '') rescue nil
              stock_name = row.at_css('.issuer-name a').text.strip rescue nil
              transaction_type = row.at_css('.tx-type').text.strip rescue nil
              security_type = row.at_css('.security-type').text.strip rescue nil
              image_url = "URL_TO_IMAGE" # Replace with actual logic to fetch image URL
              current_time = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')

              officials_csv << [politician_name, party, state, image_url, current_time, current_time]
              stocks_csv << [stock_name]
              # Placeholder IDs for demonstration; in practice, you would need actual IDs or a strategy to generate them.
              official_id = 1
              stock_id = 1
              trades_csv << [official_id, stock_id, transaction_type, volume, security_type]
            end
          end
        end
      end
    end
  end
end

def copy_csv_to_database(csv_file_path, table_name, columns)
  conn = PG.connect(dbname: 'insiderinsight', user: 'insiderinsight', password: 'aRnknxfU9Nc43mC3F3cSiGXP332phIz8', host: 'dpg-co7cu6n109ks7386lva0-a

 ')
  copy_command = "COPY #{table_name}(#{columns.join(',')}) FROM '#{csv_file_path}' DELIMITER ',' CSV HEADER;"
  conn.exec(copy_command)
rescue PG::Error => e
  puts e.message
ensure
  conn&.close
end

OfficialsScraper.scrape
