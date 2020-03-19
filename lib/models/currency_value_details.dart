class CurrencyMarketValueDetails {
  String _market;
  String _change24Hour;
  String _high;
  String _low;
  String _volume;
  String _lastPrice;
  String _bid;
  String _ask;
  int _timestamp;

  CurrencyMarketValueDetails(
      {String market,
        String change24Hour,
        String high,
        String low,
        String volume,
        String lastPrice,
        String bid,
        String ask,
        int timestamp}) {
    this._market = market;
    this._change24Hour = change24Hour;
    this._high = high;
    this._low = low;
    this._volume = volume;
    this._lastPrice = lastPrice;
    this._bid = bid;
    this._ask = ask;
    this._timestamp = timestamp;
  }

  String get market => _market;
  set market(String market) => _market = market;
  String get change24Hour => _change24Hour;
  set change24Hour(String change24Hour) => _change24Hour = change24Hour;
  String get high => _high;
  set high(String high) => _high = high;
  String get low => _low;
  set low(String low) => _low = low;
  String get volume => _volume;
  set volume(String volume) => _volume = volume;
  String get lastPrice => _lastPrice;
  set lastPrice(String lastPrice) => _lastPrice = lastPrice;
  String get bid => _bid;
  set bid(String bid) => _bid = bid;
  String get ask => _ask;
  set ask(String ask) => _ask = ask;
  int get timestamp => _timestamp;
  set timestamp(int timestamp) => _timestamp = timestamp;

  CurrencyMarketValueDetails.fromJson(Map<String, dynamic> json) {
    _market = json['market'];
    _change24Hour = json['change_24_hour'];
    _high = json['high'];
    _low = json['low'];
    _volume = json['volume'];
    _lastPrice = json['last_price'];
    _bid = json['bid'];
    _ask = json['ask'];
    _timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['market'] = this._market;
    data['change_24_hour'] = this._change24Hour;
    data['high'] = this._high;
    data['low'] = this._low;
    data['volume'] = this._volume;
    data['last_price'] = this._lastPrice;
    data['bid'] = this._bid;
    data['ask'] = this._ask;
    data['timestamp'] = this._timestamp;
    return data;
  }
}
