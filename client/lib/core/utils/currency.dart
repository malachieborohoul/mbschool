   
       final Map<String, double> exchangeRates = {
    'CAD_TO_USD': 0.75, // 1 CAD = 0.75 USD
    'CAD_TO_XOF': 450.0, // 1 CAD = 450 XOF (exemple)
    'USD_TO_XOF': 600.0, // 1 USD = 600 XOF (exemple)
  };
   String getExchangeRate(String selectedCurrencyFrom, String selectedCurrencyTo) {
    if (selectedCurrencyFrom == selectedCurrencyTo) {
      return '1.00';
    } else if (selectedCurrencyFrom == 'CAD' && selectedCurrencyTo == 'USD') {
      return exchangeRates['CAD_TO_USD']!.toStringAsFixed(2);
    } else if (selectedCurrencyFrom == 'CAD' && selectedCurrencyTo == 'XOF') {
      return exchangeRates['CAD_TO_XOF']!.toStringAsFixed(2);
    } else if (selectedCurrencyFrom == 'USD' && selectedCurrencyTo == 'XOF') {
      return exchangeRates['USD_TO_XOF']!.toStringAsFixed(2);
    } else if (selectedCurrencyFrom == 'USD' && selectedCurrencyTo == 'CAD') {
      return (1 / exchangeRates['CAD_TO_USD']!).toStringAsFixed(2);
    } else if (selectedCurrencyFrom == 'XOF' && selectedCurrencyTo == 'CAD') {
      return (1 / exchangeRates['CAD_TO_XOF']!).toStringAsFixed(2);
    } else if (selectedCurrencyFrom == 'XOF' && selectedCurrencyTo == 'USD') {
      return (1 / exchangeRates['USD_TO_XOF']!).toStringAsFixed(2);
    }
    return '1.00';
  }