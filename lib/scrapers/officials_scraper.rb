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

        transaction_type = row.at_css('.tx-type').text.strip rescue nil
        transaction_count = row.at_css('.transaction-count').text.strip rescue nil # Adjust selector
        security_type = row.at_css('.security-type').text.strip rescue nil # Adjust selector

        next unless politician_name && party && state && stock_name

        official = Official.find_or_create_by(name: politician_name) do |o|
          o.party_affiliation = party
          o.state = state
        end

        stock = Stock.find_or_create_by(name: stock_name)
        if stock.persisted?
          puts "stock persisted with ID: #{stock.id}"
        else
          puts "stock not saved: #{stock.errors.full_messages.join(', ')}"
        end



        Trade.create!(
          official: official,
          stock: stock,
          transaction_type: transaction_type,
          transaction_count: transaction_count.to_i,
          security_type: security_type
        )

        puts "Processed: #{politician_name}, Party: #{party}, State: #{state}, Stock: #{stock_name}, Transaction Type: #{transaction_type}, Transaction Count: #{transaction_count}, Security Type: #{security_type}"
      end
    end
  end
end

OfficialsScraper.scrape
