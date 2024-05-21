<h1> Stock Comparison App </h1>

<h2> Table of Contents </h2>

- [Group Composition](#group-composition)
- [Architecture of the system](#architecture-of-the-system)
- [Navigation Map](#navigation-map)
- [Features / How To Use](#features--how-to-use)
	- [View Single Company Stocks](#view-single-company-stocks)
	- [View Two Company Stocks](#view-two-company-stocks)
- [Scenario Tests](#scenario-tests)
	- [Offline Access](#offline-access)
	- [Online Access to One Company](#online-access-to-one-company)
	- [Online Access to Two Companies](#online-access-to-two-companies)

## Group Composition

| Name | Email | GitHub |
| --- | --- | --- |
| Carlos Veríssimo | up201907716@up.pt | [carlosverissimo3001](https://github.com/carlosverissimo3001)
| Nuno Jesus | up201905477@up.pt | [Nuno-Jesus](https://github.com/Nuno-Jesus)

## Architecture of the system

The application uses the AlphaVantage API to fetch the stock data. The API provides several endpoints to get data, but we are using only the following two:

1. **Time Series Daily (TIME_SERIES_DAILY)**: This endpoint returns the daily time series (date, daily open, daily high, daily low, daily close, daily volume) of the global equity specified, covering 20+ years of historical data. The most recent data point is the prices and volume information of the current trading day, updated realtime.

2. **Company Overview (OVERVIEW)**: This endpoint provides a general overview of the company, including the name, symbol, sector, industry, and a brief description of the company.

The API is called whenever the user submits companies into analysis. Until the user leaves the company screen, no other calls will be made.

Other than the API, the application makes use of the `syncfusion_flutter_charts` package to render the stock data in a chart. The package provides several types of charts, but we are using the candle and spline charts.

## Navigation Map

The application has two main screens: the home screen and the company screen. A third screen can be used in case the user is offline.

<p align="center">
  <img src="/images/navigation_map.png" >
</p>

## Features / How To Use

On the startup, the application will render a list of 10 well-known companies in the stock market. From the very first screen, one can choose between a light or dark themed screens

| Light Theme | Dark Theme |
| --- | --- |
| <img src="/images/light_theme_home_screen.png" width=300>| <img src="/images/dark_theme_home_screen.png" width=300>|


### View Single Company Stocks

From the home page the user can select a company from the list and click on the "Analyse" button...

<p align="center">
  <img src="/images/light_theme_select_one.png" width=300>
</p>

...to view the stock chart of the selected company. Below the chart, the user can see some metrics and a brief description of the company. It's also possible to switch from a candle chart to a spline chart and vice-versa by clicking on the Action Button near the theme switcher one.

<table>
	<tr>
		<th> Candle Chart </th>
		<th> Spline Chart </th>
	</tr>
	<tr>
		<td><img src="/images/light_theme_one_company_candle_chart.png" width=300></td>
		<td><img src="/images/light_theme_one_company_spline_chart.png" width=300></td>
	</tr>
</table>

### View Two Company Stocks

From the home page the user can select two companies from the list and click on the "Analyse" button...

<p align="center">
  <img src="/images/light_theme_select_two.png" width=300>
</p>

...to access a comparison of the companies stocks on the same chart. This view inherits the functionalities of the single company view, such as the metrics and the description of the companies.
However, by default only the first company information will be displayed on the screen. By swiping the company card to the right, the UI will display the second company information. The reverse is also true.


<table>
	<tr>
		<th> Selected First Card </th>
		<th> Selected Second Card </th>
	</tr>
	<tr>
		<td><img src="/images/light_theme_two_company_first_card.png" width=300></td>
		<td><img src="/images/light_theme_two_company_second_card.png" width=300></td>
	</tr>
</table>

## Scenario Tests

### Offline Access
The user can access the application without an internet connection. The application will display a message to the user, informing that the application is offline and that the data may not be up to date.

1. The user opens the application without an internet connection.
2. The user will see a message informing that he's offline and needs to connect to the internet.

### Online Access to One Company
The user can access the application with an internet connection and view the stocks of a single company.

1. The user opens the application with an internet connection.
2. The user selects a company from the company list.
3. The user clicks on the "Analyse" button.
4. The user will see the stock chart of the selected company, among metrics and a brief description of the company.

### Online Access to Two Companies
The user can access the application with an internet connection and view the stocks of two companies.

1. The user opens the application with an internet connection.
2. The user selects two companies from the company list.
3. The user clicks on the "Analyse" button.
4. The user will see the stock chart of the selected companies, among metrics and a brief description of the companies.
