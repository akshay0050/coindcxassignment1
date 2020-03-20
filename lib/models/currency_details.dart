class CurrencyDetails {
  String _targetCurrencyShortName;
  String _coindcxName;
  String _lastPrice;
  String _baseCurrencyShortName;
  String _high;
  String _low;
  String _change24Hour;

  CurrencyDetails(
      {String targetCurrencyShortName,
        String coindcxName,
        String lastPrice,
        String baseCurrencyShortName,
        String high,
        String low,
        String change24Hour}) {
    this._targetCurrencyShortName = targetCurrencyShortName;
    this._coindcxName = coindcxName;
    this._lastPrice = lastPrice;
    this._baseCurrencyShortName = baseCurrencyShortName;
    this._high = high;
    this._low = low;
    this._change24Hour = change24Hour;
  }

  String get targetCurrencyShortName => _targetCurrencyShortName;
  set targetCurrencyShortName(String targetCurrencyShortName) =>
      _targetCurrencyShortName = targetCurrencyShortName;
  String get coindcxName => _coindcxName;
  set coindcxName(String coindcxName) => _coindcxName = coindcxName;
  String get lastPrice => _lastPrice;
  set lastPrice(String lastPrice) => _lastPrice = lastPrice;
  String get baseCurrencyShortName => _baseCurrencyShortName;
  set baseCurrencyShortName(String baseCurrencyShortName) =>
      _baseCurrencyShortName = baseCurrencyShortName;
  String get high => _high;
  set high(String high) => _high = high;
  String get low => _low;
  set low(String low) => _low = low;
  String get change24Hour => _change24Hour;
  set change24Hour(String change24Hour) => _change24Hour = change24Hour;

  CurrencyDetails.fromJson(Map<String, dynamic> json) {
    _targetCurrencyShortName = json['targetCurrencyShortName'];
    _coindcxName = json['coindcxName'];
    _lastPrice = json['lastPrice'];
    _baseCurrencyShortName = json['baseCurrencyShortName'];
    _high = json['high'];
    _low = json['low'];
    _change24Hour = json['change24Hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['targetCurrencyShortName'] = this._targetCurrencyShortName;
    data['coindcxName'] = this._coindcxName;
    data['lastPrice'] = this._lastPrice;
    data['baseCurrencyShortName'] = this._baseCurrencyShortName;
    data['high'] = this._high;
    data['low'] = this._low;
    data['change24Hour'] = this._change24Hour;
    return data;
  }
}
