
# Stock Trading App

## Overview

The Stock Trading App allows users to monitor up to two stocks by adding them to a personalized watchlist. The app provides live charts for the selected stocks, enabling users to track price movements and trends over time. Initially, the app was developed using static data, which was later transitioned to dynamic data using the FMP (Financial Modeling Prep) API.

## Features

### 1. Watchlist
- **Add/Remove Stocks:** Users can add up to two stocks to their watchlist from a predefined list or via a search function.
- **Stock Display:** The watchlist displays the stock symbol, current price, and percentage change, providing a quick overview of the stock's performance.

### 2. Live Stock Charts
- **Chart Display:** Users can view detailed charts for each stock in the watchlist, showing the stock's price movements over various time frames.

### 3. API Integration
- **Live Data Integration:** The app fetches real-time stock data using the FMP API.
- **Fallback to Static Data:** Initially, the app used static data for displaying stock information and charts before integrating with live data.

## Architecture

The app follows the MVC (Model-View-Controller) architecture pattern, ensuring a clean and organized codebase. The `Provider` package is used for state management, making it easier to manage and update the state across different app parts.

## Installation

1. **Clone the Repository:**
   ```bash
   git clone url
   ```
2. **Navigate to the Project Directory:**
   ```bash
   cd stock_trading_app
   ```
3. **Install Dependencies:**
   ```bash
   flutter pub get
   ```
4. **Run the App:**
   ```bash
   flutter run
   ```

## JSON Files
The app was initially tested with predefined JSON files containing stock data, such as prices and historical data, to create and test the UI before integrating with live data.

## Contact details

 salmanulfaris4511@gmail.com,
 9895840715
