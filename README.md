# Insider Insight Official Documentation

Welcome to the official documentation for Insider Insight.

## Documentation

For detailed information and component references, visit the [Daisy UI Documentation](https://daisyui.com/).

## Demo

To see Daisy UI in action, check out our [live demo](https://insiderinsight.onrender.com/).

## Repository Branches

- **Rails 7 + esbuild (Main Branch)**: The current stable version.
- **Rails 6 + webpacker**: For those using older versions of Rails, you can find it [here](https://github.com/mkhairi/rails-daisyui-starter/tree/rails6).

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Before you begin, ensure you have the following installed:
- Ruby (version specified in `.ruby-version`)
- Rails (compatible with Rails 6 and Rails 7)
- Yarn
- Node.js

### Installation

Follow these steps to set up the project locally:

```sh
# Clone the repository
git clone https://github.com/evolshenanigans/insiderinsight.git
cd insiderinsight

# Install dependencies
bundle install
yarn install

# Set up the database
rails db:create
rails db:migrate

# Start the development server
./bin/dev
```

## Running the Scraper

The scraper fetches information about government officials' trades and stores the data in CSV files. These files can then be uploaded to your personal database.

### Prerequisites

Ensure you have Ruby installed along with the following gems: `puppeteer`, `nokogiri`, `csv`, `date`, and `pg`.

### Steps to Run the Scraper

1. Navigate to the directory containing the scraper script.
2. Run the scraper script:
   ```sh
   ruby scraper.rb
   ```
3. After the scraper completes, three CSV files (`officials.csv`, `stocks.csv`, `trades.csv`) will be created in the current directory.

### Uploading to Database

To upload the data from CSV files to your PostgreSQL database:

1. Ensure your PostgreSQL credentials and database details are correctly configured in the script.
2. Use the `copy_csv_to_database` method in the script, specifying the path to each CSV file and the corresponding database table.

### Common Issues


**Issue**: wrong ruby version
- **Solution**: the current version of this project only supports up to ruby 3.2.1.

**Issue**: Scraper fails to fetch data due to a change in the website's HTML structure.
- **Solution**: Check if the website's structure has changed and adjust the CSS selectors in the script accordingly.

**Issue**: Database connection errors.
- **Solution**: Verify that your PostgreSQL credentials and database details are correct. Ensure your PostgreSQL service is running.

## FAQ

**Q: What versions of Rails does Daisy UI support?**
A: Daisy UI supports Rails 6 and Rails 7. Please switch to the appropriate branch as per your Rails version requirement.

**Q: Where can I find component examples?**
A: You can find examples and usage guidelines on the [Daisy UI Documentation](https://daisyui.com/) site and in the demo application.

## Troubleshooting

**Issue: Styles are not applying correctly.**
- **Solution**: Ensure Tailwind CSS is correctly installed and imported into your project. Check your `tailwind.config.js` and ensure it's configured properly.

**Issue: Getting a database error during setup.**
- **Solution**: Make sure you've created the database with `rails db:create` before running migrations. Also, verify your database configuration in `config/database.yml`.
