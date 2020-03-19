import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:coin_dcx_assignment/network_calls/api_url_endpoint.dart';
import 'package:http/io_client.dart' as http;

part 'api_services.chopper.dart';
@ChopperApi()
abstract class ApiService extends ChopperService {
  static ApiService create(String baseUrl) {
    final client = ChopperClient(
      client: http.IOClient(
        HttpClient()..connectionTimeout = const Duration(seconds: 60),
      ),
      baseUrl: baseUrl,
      //services: [_$ApiService()],
      converter: JsonConverter(),
    );
    return _$ApiService(client);
  }

  @Get(path: API_ENDPOINT.getTicker)
  Future<Response> getAllCoinValueDetails();

  @Get(path: API_ENDPOINT.getMarketDetails)
  Future<Response> getAllCoinMarketDetails();

}
