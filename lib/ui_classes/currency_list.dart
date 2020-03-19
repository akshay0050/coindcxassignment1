import 'dart:convert';

import 'package:coin_dcx_assignment/models/currency_value_details.dart';
import 'package:coin_dcx_assignment/network_calls/api_services.dart';
import 'package:coin_dcx_assignment/network_calls/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  final apiServiceObj = ApiService.create(Env.BASE_URL);

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),

          ],
        ),
      ),

    );;
  }

  void getCurrencyMarketValue() async {
    List<CurrencyMarketValueDetails> currencyDetailsList = List<CurrencyMarketValueDetails>();

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
          }

         // ((res.body as List).map((i) => new CurrencyMarketValueDetails.fromJson(i)) as Map<dynamic,CurrencyMarketValueDetails>).forEach((k,v) => currencyDetailsList.add(v));
        }
      }
    } on Exception catch (e) {
      print("exception $e");
    } catch (error) {
      print("error $error");
    }
  }
}
