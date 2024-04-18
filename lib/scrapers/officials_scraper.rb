# development scraper

require 'puppeteer'
require 'nokogiri'

# OfficialsScraper scrapes data about government officials' stock trades from a specific webpage.
class OfficialsScraper
  # URL to scrape, includes parameters to filter transactions over the last 30 days.
  URL = 'https://www.capitoltrades.com/trades?txDate=30d&per_page=96'

  # Main scraping method.
  def self.scrape
    Puppeteer.launch(headless: true) do |browser|
      page = browser.new_page
      page.goto(URL, wait_until: 'networkidle0')
      html_content = page.content
      doc = Nokogiri::HTML(html_content)

      # Process each trade entry on the webpage.
      doc.css('tr.q-tr').each do |row|
        politician_name = safely_extract_text(row, '.politician-name a')
        party = safely_extract_text(row, '.party')
        state = safely_extract_text(row, '.us-state-compact')
        volume = safely_extract_numeric_value(row, '.cell--volume .q-value')
        stock_name = safely_extract_text(row, '.issuer-name a')
        transaction_type = safely_extract_text(row, '.tx-type')
        security_type = safely_extract_text(row, '.security-type')

        # Skip the current iteration if essential data is missing.
        next unless politician_name && party && state && stock_name

        # Attempt to find or create official and stock records.
        official = find_or_create_official(politician_name, party, state)
        stock = find_or_create_stock(stock_name)

        # Log error message if stock not saved, else continue.
        if stock.errors.any?
          puts "Stock not saved: #{stock.errors.full_messages.join(', ')}"
          next
        end

        # Create a new trade entry and log the processed information.
        create_trade(official, stock, transaction_type, volume, security_type)
        log_processed_data(politician_name, party, state, stock_name, transaction_type, volume, security_type)
      end
    end
  end

  # Safely extracts text content from a specified CSS selector.
  def self.safely_extract_text(row, selector)
    row.at_css(selector).text.strip rescue nil
  end

  # Safely extracts numeric values from text, removing non-numeric characters.
  def self.safely_extract_numeric_value(row, selector)
    row.at_css(selector).text.strip.gsub(/[^\d]/, '') rescue nil
  end

  # Finds or creates an official with the given details.
  def self.find_or_create_official(name, party, state)
    Official.find_or_create_by(name: name) do |official|
      official.party_affiliation = party
      official.state = state
    end
  end

  # Finds or creates a stock with the given name.
  def self.find_or_create_stock(name)
    Stock.find_or_create_by(name: name)
  end

  # Creates a trade record.
  def self.create_trade(official, stock, transaction_type, volume, security_type)
    Trade.create!(
      official: official,
      stock: stock,
      transaction_type: transaction_type,
      transaction_count: volume,
      security_type: security_type
    )
  end

  # Logs the processed data to the console.
  def self.log_processed_data(name, party, state, stock_name, transaction_type, volume, security_type)
    puts "Processed: #{name}, Party: #{party}, State: #{state}, Stock: #{stock_name}, Transaction Type: #{transaction_type}, Volume: #{volume}, Security Type: #{security_type}"
  end
end

# Start the scraping process.
OfficialsScraper.scrape
