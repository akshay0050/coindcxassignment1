import 'dart:convert';

import 'package:coin_dcx_assignment/models/coin_market_details.dart';
import 'package:coin_dcx_assignment/models/currency_details.dart';
import 'package:coin_dcx_assignment/models/currency_value_details.dart';
import 'package:coin_dcx_assignment/network_calls/api_services.dart';
import 'package:coin_dcx_assignment/network_calls/env.dart';
import 'package:coin_dcx_assignment/style/Style.dart';
import 'package:coin_dcx_assignment/utility/common_msg.dart';
import 'package:coin_dcx_assignment/utility/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrencyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurrencyListManageState();
  }
}

class CurrencyListManageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CurrencyListState();
  }
}

class _CurrencyListState extends State<CurrencyListManageState> {
  ScrollController controller;
  final apiServiceObj = ApiService.create(Env.BASE_URL);
  List<CurrencyMarketValueDetails> currencyDetailsList =
      List<CurrencyMarketValueDetails>();
  List<CoinMarketDetails> coinMarketDetailsList = List<CoinMarketDetails>();
  List<CurrencyDetails> currencyDetailList = List<CurrencyDetails>();
  List<CurrencyDetails> currencyDetailListToShow = List<CurrencyDetails>();
  Map<String, CurrencyDetails> currencyDetailMap = Map<String, CurrencyDetails>();
  bool isAlphbeticallyOrdered = false;
  final _searchController =  TextEditingController();
  bool _isLoading = true;
  bool _isError = false;
  String errorMsg = "Please check your Internet Connection and Try again";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addSearchBarListner();
    getCurrencyMarketValue();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Coin DCX"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              getCurrencyMarketValue();
            },
          )
        ],
      ),
      body:
         this._isLoading ? _onLoading() :
         (this._isError ? buildErrorScreen() :   buildCurrencyList())

    );
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
    _searchController.dispose();
  }

  Widget buildCurrencyList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        searchInputBox(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 5.0, top: 5.0),
                child: Text(
                    "Alphabetical"
                )
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0),
              child:
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                spacing: -15.0,
                children: <Widget>[
                  new InkWell(
                      onTap: onAlphbeticallyArranged,
                      child: Container(
                          child:  Icon(
                            Icons.arrow_drop_up,
                            color: isAlphbeticallyOrdered ? Colors.black : Colors.red,
                          ))
                  ),
                  new InkWell(
                    onTap: onAlphbeticallyArranged,
                    child: Container(
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: isAlphbeticallyOrdered ? Colors.red : Colors.black,
                        )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Expanded(
          child: currencyDetailListToShow.length > 0
              ? new Scrollbar(
            child: new ListView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                return Card(
                    margin: EdgeInsets.all(5.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 2.0,
                    child: InkWell(
                      splashColor: Colors.deepPurple,
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SvgPicture.network(
                                        "https://coindcx.com/assets/coins/${currencyDetailListToShow[index].targetCurrencyShortName}.svg",
                                        // placeholderBuilder: (context) => CircularProgressIndicator(),
                                        placeholderBuilder: (context) => Container(
                                          child: const Icon(Icons.error),
                                        ),
                                        height: 50.0,
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                currencyDetailListToShow[index]
                                                    .coindcxName,
                                                style: Style.coinName,
                                              ),
                                              Text(
                                                currencyDetailListToShow[index]
                                                    .baseCurrencyShortName,
                                                style: Style.subCoinName,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child:
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(currencyDetailListToShow[index]
                                                    .lastPrice,
                                                    style: (currencyDetailListToShow[
                                                    index]
                                                        .change24Hour)
                                                        .contains("-") ? Style.negativeValue : Style.positiveValue),
                                                Container(
                                                    child: (currencyDetailListToShow[
                                                    index]
                                                        .change24Hour)
                                                        .contains("-")
                                                        ? const Icon(
                                                      Icons.arrow_downward,
                                                      color: Colors.red,
                                                    )
                                                        : const Icon(
                                                      Icons.arrow_upward,
                                                      color: Colors.green,
                                                    )),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Icon(Icons.keyboard_arrow_down,
                                      size: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),

                                ],
                              ),
                          ),
                      onTap: () {
                        _settingModalBottomSheet(
                            context, currencyDetailListToShow[index]);
                      },
                    ));
              },
              itemCount: currencyDetailListToShow.length,
            ),
          )
              : Container(),
        ),
      ],
    );
  }

//to search bar
  Widget searchInputBox() {
    return Container(
     // padding: formInputPadding,
      child: TextFormField(
        maxLength: 20,
        keyboardType: TextInputType.text,
        controller: _searchController,
        textCapitalization: TextCapitalization.characters,
        textInputAction: TextInputAction.next,

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          prefixIcon: Icon(Icons.search),
          counter: Offstage(),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.purple),
          ),
          labelText: 'Search Here',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              _searchController.clear();
              getCurrencyCoinsList();
            },
          ),
        ),
      ),
    );
  }

  //to create error view
  Widget buildErrorScreen(){
    return
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                  child: const Icon(
                    Icons.network_check,
                    color: Colors.green,
                    size: 100.0,
                  )),
              Padding(
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
                child: Text(
                  this.errorMsg,
                  style: Style.coinName,
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                splashColor: Colors.lightBlueAccent,
                onTap: getCurrencyMarketValue,
                child: Container(
                  child: Icon(
                    Icons.refresh,
                    size: 50.0,
                    color: Colors.purple,
                  ),
                )
              )



            ]
        ),
      ));
  }

  void addSearchBarListner(){
    _searchController.addListener(performSearchOperation);
  }
  // to get coin list based on user's entered text in search view
  void performSearchOperation(){
  String searchedText = _searchController.text;
  setState(() {
    if(searchedText != null && searchedText.isNotEmpty) {
      this.currencyDetailListToShow.retainWhere((object) =>
      (object.baseCurrencyShortName.toString().toLowerCase()).contains(searchedText.toLowerCase()));
    } else {
     // this.currencyDetailListToShow = currencyDetailListToShow;
      getCurrencyCoinsList();
    }
  });

  }

  void getCurrencyMarketValue() async {
    bool isInternetAvailable = await Utils.isInternetConnectionAvailable(); // internet connectivity check
    if(!isInternetAvailable) {
      this.showError(CommonMessage.noInternetMsg);
      return;
    }
    setState(() {
      this._isLoading = true; // to show loader until UI is loading
    });
    var res;
    try {
      res = await apiServiceObj.getAllCoinValueDetails(); //call to ticker api for currency market values
      if (res.statusCode == 200) {
        if (res != null && res.body != null) {
          var currencyDetailsListObj = res.body;
          if (currencyDetailsListObj != null) {
            for (var data in currencyDetailsListObj) {
              CurrencyMarketValueDetails details =
                  CurrencyMarketValueDetails.fromJson(data);
              currencyDetailsList.add(details);
            }
            getAllCurrencyDetails();
          }
        } else{
          showError(CommonMessage.networkErrortMsg);
        }
      } else {
        showError(CommonMessage.networkErrortMsg);
      }
    } on Exception catch (e) {
      showError(CommonMessage.networkErrortMsg);
    } catch (error) {
      showError(CommonMessage.networkErrortMsg);
    }
  }

  void getAllCurrencyDetails() async {
    var res;
    try {
      res = await apiServiceObj.getAllCoinMarketDetails(); //call market detail api for currency market details
      if (res.statusCode == 200) {
        this.hideLoader();
        if (res != null && res.body != null) {
          var coinMarketDetailsListObj = res.body;
          if (coinMarketDetailsListObj != null) {
            for (var data in coinMarketDetailsListObj) {
              CoinMarketDetails details = CoinMarketDetails.fromJson(data);
              coinMarketDetailsList.add(details);
            }
            getCurrencyCoinsList();
          }
        }
      } else{
        this.showError(CommonMessage.networkErrortMsg);
      }
    } on Exception catch (e) {
      this.showError(CommonMessage.networkErrortMsg);
    } catch (error) {
      this.showError(CommonMessage.networkErrortMsg);
    }
  }
  // to hide loading progressbar
  void hideLoader() {
    setState(() {
      this._isLoading = false;
      this._isError = false;
    });
  }
  // show error view
  void showError(String msg){
    setState(() {
      this._isError = true;
      this._isLoading = false;
      this.errorMsg = msg;
    });
  }

  void getCurrencyCoinsList() {
    // mapping data from ticker api and market detail api to show result on screen
    for (var coinMarketDetails in coinMarketDetailsList) {
      for (var currencyDetails in currencyDetailsList) {
        if (coinMarketDetails.coindcxName == currencyDetails.market) {
          CurrencyDetails valueDetails = CurrencyDetails();
          valueDetails.coindcxName = coinMarketDetails.coindcxName;
          valueDetails.targetCurrencyShortName =
              coinMarketDetails.targetCurrencyShortName;
          valueDetails.lastPrice = currencyDetails.lastPrice;
          valueDetails.baseCurrencyShortName =
              coinMarketDetails.baseCurrencyShortName;
          valueDetails.high = currencyDetails.high;
          valueDetails.low = currencyDetails.low;
          valueDetails.change24Hour = currencyDetails.change24Hour;
          currencyDetailMap.putIfAbsent(
              coinMarketDetails.coindcxName, () => valueDetails);
          break; // to stop loop after getting desired value
        }
      }
    }
    if (currencyDetailMap != null && currencyDetailMap.length > 0) {
      currencyDetailList = currencyDetailMap.values.toList();
      if(currencyDetailListToShow != null && currencyDetailListToShow.length> 0) {
        // to avoid adding duplicate data because this function is getting called multiple time
        this.currencyDetailListToShow.clear();
      }
      currencyDetailListToShow.addAll(currencyDetailList);
      onAlphbeticallyArranged();

//        if(currencyDetailList.length > 100) {
//          currencyDetailList.setRange(0, 100, currencyDetailListToShow);
//        } else {
//          currencyDetailListToShow.addAll(currencyDetailList);
//        }
    }
  }

  void _scrollListener() {
//    if (controller.position.extentAfter < 100) {
//      setState(() {
//        //  currencyDetailListToShow.addAll(currencyDetailList.setRange(101, 200, currencyDetailListToShow));
//      });
//    }
  }

  //to show bottom bar on click on currency card
  void _settingModalBottomSheet(context, currencyDetail) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Card(
                    margin: EdgeInsets.all(5.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 5.0,
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: SvgPicture.network(
                                "https://coindcx.com/assets/coins/${currencyDetail.targetCurrencyShortName}.svg",
                                placeholderBuilder: (context) => Container(
                                  child: Icon(Icons.error),
                                ),

                                height: 50.0,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child:
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child:
                                      Text(currencyDetail.coindcxName,
                                          style: Style.coinName),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child:
                                      Text(
                                        "${currencyDetail.baseCurrencyShortName}/${currencyDetail.targetCurrencyShortName}",
                                        style: Style.subCoinName,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child:
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child:
                                      Text("Last Traded",
                                          style: Style.subCoinName),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child:
                                      Text(
                                        currencyDetail.lastPrice,
                                        style: Style.coinName,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child:
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child:
                                      Text("24h High",
                                          style: Style.subCoinName),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child:
                                      Text(
                                        currencyDetail.high,
                                        style: Style.coinName,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child:
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child:
                                      Text("24h Low",
                                          style: Style.subCoinName),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child:
                                      Text(
                                        currencyDetail.low,
                                        style: Style.coinName,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child:
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child:
                                      Text("24h Change",
                                          style: Style.subCoinName),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child:
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(currencyDetail.change24Hour,
                                              style: (currencyDetail.change24Hour)
                                                  .contains("-") ? Style.negativeValue : Style.positiveValue),
                                          Container(
                                              child: (currencyDetail.change24Hour)
                                                  .contains("-")
                                                  ? const Icon(
                                                Icons.arrow_downward,
                                                color: Colors.red,
                                              )
                                                  : const Icon(
                                                Icons.arrow_upward,
                                                color: Colors.green,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ],
                        ),
                        ))
              ],
            ),
          );
        });
  }

  //to arrange List by alphabetically
  //common function called for alphabetical and reverse order to wrong avoid click on up and down arrow
  void onAlphbeticallyArranged() {
    setState(() {
      this.currencyDetailListToShow.sort((obj1, obj2) => obj1.coindcxName.toString().toLowerCase().compareTo(obj2.coindcxName.toString().toLowerCase()));
      if(this.isAlphbeticallyOrdered) {
        this.currencyDetailListToShow =
            this.currencyDetailListToShow.reversed.toList();
        this.isAlphbeticallyOrdered = false;
      } else {
        this.isAlphbeticallyOrdered = true;
      }
    });
  }

  // to show loader while data is getting through api call
  Widget _onLoading() {
    return Center(
        child:
        new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child:  new Text(CommonMessage.loadingMsg),
            )

          ],
        ),
    );
  }
}
