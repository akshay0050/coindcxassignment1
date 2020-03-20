class CoinMarketDetails {
  String _coindcxName;
  String _baseCurrencyShortName;
  String _targetCurrencyShortName;
  String _targetCurrencyName;
  String _baseCurrencyName;
  String _minQuantity;
  String _maxQuantity;
  String _minPrice;
  String _maxPrice;
  String _minNotional;
  String _baseCurrencyPrecision;
  String _targetCurrencyPrecision;
  String _step;
  List<String> _orderTypes;
  String _symbol;
  String _ecode;
  String _maxLeverage;
  String _maxLeverageShort;
  String _pair;
  String _status;

  CoinMarketDetails(
      {String coindcxName,
        String baseCurrencyShortName,
        String targetCurrencyShortName,
        String targetCurrencyName,
        String baseCurrencyName,
        String minQuantity,
        String maxQuantity,
        String minPrice,
        String maxPrice,
        String minNotional,
        String baseCurrencyPrecision,
        String targetCurrencyPrecision,
        String step,
        List<String> orderTypes,
        String symbol,
        String ecode,
        String maxLeverage,
        String maxLeverageShort,
        String pair,
        String status}) {
    this._coindcxName = coindcxName;
    this._baseCurrencyShortName = baseCurrencyShortName;
    this._targetCurrencyShortName = targetCurrencyShortName;
    this._targetCurrencyName = targetCurrencyName;
    this._baseCurrencyName = baseCurrencyName;
    this._minQuantity = minQuantity;
    this._maxQuantity = maxQuantity;
    this._minPrice = minPrice;
    this._maxPrice = maxPrice;
    this._minNotional = minNotional;
    this._baseCurrencyPrecision = baseCurrencyPrecision;
    this._targetCurrencyPrecision = targetCurrencyPrecision;
    this._step = step;
    this._orderTypes = orderTypes;
    this._symbol = symbol;
    this._ecode = ecode;
    this._maxLeverage = maxLeverage;
    this._maxLeverageShort = maxLeverageShort;
    this._pair = pair;
    this._status = status;
  }

  String get coindcxName => _coindcxName;
  set coindcxName(String coindcxName) => _coindcxName = coindcxName;
  String get baseCurrencyShortName => _baseCurrencyShortName;
  set baseCurrencyShortName(String baseCurrencyShortName) =>
      _baseCurrencyShortName = baseCurrencyShortName;
  String get targetCurrencyShortName => _targetCurrencyShortName;
  set targetCurrencyShortName(String targetCurrencyShortName) =>
      _targetCurrencyShortName = targetCurrencyShortName;
  String get targetCurrencyName => _targetCurrencyName;
  set targetCurrencyName(String targetCurrencyName) =>
      _targetCurrencyName = targetCurrencyName;
  String get baseCurrencyName => _baseCurrencyName;
  set baseCurrencyName(String baseCurrencyName) =>
      _baseCurrencyName = baseCurrencyName;
  String get minQuantity => _minQuantity;
  set minQuantity(String minQuantity) => _minQuantity = minQuantity;
  String get maxQuantity => _maxQuantity;
  set maxQuantity(String maxQuantity) => _maxQuantity = maxQuantity;
  String get minPrice => _minPrice;
  set minPrice(String minPrice) => _minPrice = minPrice;
  String get maxPrice => _maxPrice;
  set maxPrice(String maxPrice) => _maxPrice = maxPrice;
  String get minNotional => _minNotional;
  set minNotional(String minNotional) => _minNotional = minNotional;
  String get baseCurrencyPrecision => _baseCurrencyPrecision;
  set baseCurrencyPrecision(String baseCurrencyPrecision) =>
      _baseCurrencyPrecision = baseCurrencyPrecision;
  String get targetCurrencyPrecision => _targetCurrencyPrecision;
  set targetCurrencyPrecision(String targetCurrencyPrecision) =>
      _targetCurrencyPrecision = targetCurrencyPrecision;
  String get step => _step;
  set step(String step) => _step = step;
  List<String> get orderTypes => _orderTypes;
  set orderTypes(List<String> orderTypes) => _orderTypes = orderTypes;
  String get symbol => _symbol;
  set symbol(String symbol) => _symbol = symbol;
  String get ecode => _ecode;
  set ecode(String ecode) => _ecode = ecode;
  String get maxLeverage => _maxLeverage;
  set maxLeverage(String maxLeverage) => _maxLeverage = maxLeverage;
  String get maxLeverageShort => _maxLeverageShort;
  set maxLeverageShort(String maxLeverageShort) =>
      _maxLeverageShort = maxLeverageShort;
  String get pair => _pair;
  set pair(String pair) => _pair = pair;
  String get status => _status;
  set status(String status) => _status = status;

  CoinMarketDetails.fromJson(Map<String, dynamic> json) {
    _coindcxName = json['coindcx_name'] ;
    _baseCurrencyShortName = json['base_currency_short_name'];
    _targetCurrencyShortName = json['target_currency_short_name'];
    _targetCurrencyName = json['target_currency_name'];
    _baseCurrencyName = json['base_currency_name'];
    _minQuantity = (json['min_quantity']).toString();
    _maxQuantity = (json['max_quantity']).toString();
    _minPrice = (json['min_price']).toString();
    _maxPrice = (json['max_price']).toString();
    _minNotional = (json['min_notional']).toString();
    _baseCurrencyPrecision = (json['base_currency_precision']).toString();
    _targetCurrencyPrecision = (json['target_currency_precision']).toString();
    _step = (json['step']).toString();
    _orderTypes = json['order_types'].cast<String>();
    _symbol = json['symbol'];
    _ecode = json['ecode'];
    _maxLeverage = (json['max_leverage']).toString();
    _maxLeverageShort = json['max_leverage_short'] != null ? (json['max_leverage_short']).toString() :"";
    _pair = json['pair'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coindcx_name'] = this._coindcxName;
    data['base_currency_short_name'] = this._baseCurrencyShortName;
    data['target_currency_short_name'] = this._targetCurrencyShortName;
    data['target_currency_name'] = this._targetCurrencyName;
    data['base_currency_name'] = this._baseCurrencyName;
    data['min_quantity'] = this._minQuantity;
    data['max_quantity'] = this._maxQuantity;
    data['min_price'] = this._minPrice;
    data['max_price'] = this._maxPrice;
    data['min_notional'] = this._minNotional;
    data['base_currency_precision'] = this._baseCurrencyPrecision;
    data['target_currency_precision'] = this._targetCurrencyPrecision;
    data['step'] = this._step;
    data['order_types'] = this._orderTypes;
    data['symbol'] = this._symbol;
    data['ecode'] = this._ecode;
    data['max_leverage'] = this._maxLeverage;
    data['max_leverage_short'] = this._maxLeverageShort;
    data['pair'] = this._pair;
    data['status'] = this._status;
    return data;
  }

  dynamic checkDouble(dynamic value) {
    if (value is double) {
      return value.round();
    } else {
      return value;
    }
  }
}
