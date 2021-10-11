import 'dart:convert';
import 'dart:io';

import 'package:metar/constants/constants.dart';
import 'package:metar/models/metar.dart';
import 'package:http/http.dart' as http;
import 'package:metar/utils/array.utils.dart';

class Api {
  Future<Metar> fetchMetar(String station) async {
    final response = await http.get(
      Uri.parse('$endpoint$station'),
      headers: {
        HttpHeaders.authorizationHeader: apikey,
      },
    );
    if (response.statusCode != 200) {}
    final responseJson = jsonDecode(response.body);
    final json = Metar.fromJson(responseJson);
    return json;
  }

  Future<List<Metar>> fetchMetarCheckWX(List<String> stations) async {
    List<Metar> metars = [];
    List<List<String>> chunks = new ArrayUtils().chunk(stationsAll, 20);
    for (int i = 0; i < chunks.length; i++) {
      final currentStations = chunks[i];
      final commaSeparatedStations = currentStations.join(',');
      final response = await http.get(
        Uri.parse('$endpointCheckWX$commaSeparatedStations'),
        headers: {
          'X-API-KEY': apikeyCheckWX,
        },
      );
      if (response.statusCode != 200) {
        return List<Metar>.generate(
            stations.length,
            (int index) =>
                new Metar(reading: 'Error occurred', station: stations[index]));
      }
      final responseJson = jsonDecode(response.body);
      List responseData = responseJson['data'];
      List<Metar> allMetars =
          transformMetarResponse(responseData, currentStations);
      metars = [...metars, ...allMetars];
    }
    print(metars);
    return metars;
  }

  List<Metar> transformMetarResponse(
      List<dynamic> responseData, List<String> currentStations) {
    List<Metar> responseList = responseData
        .map((e) => new Metar(reading: e, station: e.substring(0, 4)))
        .toList();
    Map responseMap = Map.fromIterable(responseList,
        key: (e) => e.station, value: (e) => e.reading);
    List<Metar> allMetars = currentStations
        .map((e) => new Metar(reading: getReading(e, responseMap), station: e))
        .toList();
    return allMetars;
  }

  String getReading(String station, Map map) {
    if (map.containsKey(station)) {
      return map[station];
    }
    return '$station Metar not found';
  }
}
