String reduceDollars(String amount) {
  double parsedValue = double.parse(amount);
  double reducedValue = 0.0;

  if (parsedValue / 1000000000000 >= 1) {
    reducedValue = parsedValue / 1000000000000;
    return '\$${reducedValue.toStringAsFixed(2)} T';
  } else if (parsedValue / 1000000000 >= 1) {
    reducedValue = parsedValue / 1000000000;
    return '\$${reducedValue.toStringAsFixed(2)} B';
  } else if (parsedValue / 1000000 >= 1) {
    reducedValue = parsedValue / 1000000;
    return '\$${reducedValue.toStringAsFixed(2)} M';
  } else if (parsedValue / 1000 >= 1) {
    reducedValue = parsedValue / 1000;
    return '\$${reducedValue.toStringAsFixed(2)} K';
  } else {
    return '\$${parsedValue.toStringAsFixed(2)}';
  }
}

String reduceDividendYield(String value){
  double parsedValue = double.parse(value) * 100;
  return '${parsedValue.toStringAsFixed(2)} %';
}