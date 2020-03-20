import 'dart:convert';

import 'package:coin_dcx_assignment/models/coin_market_details.dart';
import 'package:coin_dcx_assignment/models/currency_details.dart';
import 'package:coin_dcx_assignment/models/currency_value_details.dart';
import 'package:coin_dcx_assignment/network_calls/api_services.dart';
import 'package:coin_dcx_assignment/network_calls/env.dart';
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
  List<CurrencyMarketValueDetails> currencyDetailsList = List<CurrencyMarketValueDetails>();
  List<CoinMarketDetails> coinMarketDetailsList = List<CoinMarketDetails>();
  List<CurrencyDetails> currencyDetailList = List<CurrencyDetails>();
  List<CurrencyDetails> currencyDetailListToShow = List<CurrencyDetails>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencyMarketValue();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency List"),
      ),
      body:
      currencyDetailListToShow.length >0 ?
      new Scrollbar(
        child: new ListView.builder(
          controller: controller,
          itemBuilder: (context, index) {
            return
              Card(
                margin: EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                elevation: 5.0,
                child:
                    InkWell(
                      splashColor: Colors.deepPurple,
                      child:
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>
                            [
                              Padding(
                                child:
                                SvgPicture.network( "https://coindcx.com/assets/coins/${currencyDetailListToShow[index].targetCurrencyShortName}.svg",
                                  // placeholderBuilder: (context) => CircularProgressIndicator(),
                                  placeholderBuilder: (context) =>
                                      Container(
                                        child: const Icon(Icons.error),),

                                  height: 50.0,),
                                padding: EdgeInsets.all(10.0),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      currencyDetailListToShow[index].coindcxName
                                  ),
                                  Text(
                                      currencyDetailListToShow[index].baseCurrencyShortName
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                      currencyDetailListToShow[index].lastPrice
                                  ),
                                  Container(
                                      child: (currencyDetailListToShow[index].change24Hour).contains("-") ?
                                      const Icon(Icons.trending_down , color: Colors.red,) :
                                      const Icon(Icons.trending_up , color: Colors.green,)),

                                ],
                              )

                            ],
                          )

                      ),
                      onTap: (){
                        _settingModalBottomSheet(context, currencyDetailListToShow[index]);
                      },
                    )
            );
          },
          itemCount: currencyDetailListToShow.length,
        ),
      ) : Container(),

    );;
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void getCurrencyMarketValue() async {
    var res;
    try {
      res = await apiServiceObj.getAllCoinValueDetails();
      if(res.statusCode == 200) {
        if(res != null && res.body != null) {
          var currencyDetailsListObj = res.body;
          if(currencyDetailsListObj != null) {
            for (var data in currencyDetailsListObj) {
              CurrencyMarketValueDetails details = CurrencyMarketValueDetails.fromJson(data);
              currencyDetailsList.add(details);
            }
            getAllCurrencyDetails();
          }
        }

      }
    } on Exception catch (e) {
      print("exception $e");
    } catch (error) {
      print("error $error");
    }

  }

  void getAllCurrencyDetails() async {
    var res;
    try {
      res = await apiServiceObj.getAllCoinMarketDetails();
      if(res.statusCode == 200) {
        if(res != null && res.body != null) {
          var coinMarketDetailsListObj = res.body;
          if(coinMarketDetailsListObj != null) {
            for (var data in coinMarketDetailsListObj) {
              CoinMarketDetails details = CoinMarketDetails.fromJson(data);
              coinMarketDetailsList.add(details);
            }
            getCurrencyCoinsList();
          }
        }
      }
    } on Exception catch (e) {
      print("exception $e");
    } catch (error) {
      print("error $error");
    }

  }

  void getCurrencyCoinsList() {
    Map<String, CurrencyDetails> currencyDetailMap = Map<String, CurrencyDetails>();
      for(var coinMarketDetails in coinMarketDetailsList) {
        for(var currencyDetails in currencyDetailsList) {
          if(coinMarketDetails.coindcxName == currencyDetails.market) {
            CurrencyDetails valueDetails = CurrencyDetails();
            valueDetails.coindcxName = coinMarketDetails.coindcxName;
            valueDetails.targetCurrencyShortName = coinMarketDetails.targetCurrencyShortName;
            valueDetails.lastPrice = currencyDetails.lastPrice;
            valueDetails.baseCurrencyShortName = coinMarketDetails.baseCurrencyShortName;
            valueDetails.high = currencyDetails.high;
            valueDetails.low = currencyDetails.low;
            valueDetails.change24Hour = currencyDetails.change24Hour;
            currencyDetailMap.putIfAbsent(coinMarketDetails.coindcxName, ()=>valueDetails);
            break;
          }
        }
      }
      if(currencyDetailMap != null && currencyDetailMap.length >0) {
        currencyDetailList = currencyDetailMap.values.toList();
        setState(() {
          currencyDetailListToShow.addAll(currencyDetailList);
        });

//        if(currencyDetailList.length > 100) {
//          currencyDetailList.setRange(0, 100, currencyDetailListToShow);
//        } else {
//          currencyDetailListToShow.addAll(currencyDetailList);
//        }
      }

  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 100) {
      setState(() {
      //  currencyDetailListToShow.addAll(currencyDetailList.setRange(101, 200, currencyDetailListToShow));
      });
    }
  }

  void _settingModalBottomSheet(context, currencyDetail){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
            Card(
            margin: EdgeInsets.all(5.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              elevation: 5.0,
              child:
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child:
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>
                    [
                      Padding(
                        child:
                        SvgPicture.network( "https://coindcx.com/assets/coins/${currencyDetail.targetCurrencyShortName}.svg",
                          // placeholderBuilder: (context) => CircularProgressIndicator(),
                          placeholderBuilder: (context) =>
                              Container(
                                child: const Icon(Icons.error),),

                          height: 50.0,),
                        padding: EdgeInsets.all(10.0),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              currencyDetail.coindcxName
                          ),
                          Text(
                              currencyDetail.baseCurrencyShortName
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                              currencyDetail.lastPrice
                          ),

                        ],
                      )

                    ],
                  )

              ))
              ],
            ),
          );
        }
    );
  }
}
