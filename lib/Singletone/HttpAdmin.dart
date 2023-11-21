import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAdmin{

  HttpAdmin();

  Future<double> pedirTemperaturasEn(double lat, double lon) async{
    var url = Uri.https('api.open-meteo.com', '/v1/forecast',
        {
          'latitude': lat.toString(),
          'longitude': lon.toString(),
          'hourly': 'temperature_2m'
        });
    print ("URL resultante -> " + url.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      //print("\nMAPA ENTERO: " + jsonResponse.toString());
      var horas = jsonResponse['hourly_units'];
      print("\nUNIDAD HORARIA: " + horas.toString());

      var jsonHourly = jsonResponse['hourly'];

      print("\nHORAS: " + jsonHourly.toString());

      print("\nTIEMPO: " + jsonHourly['time'].toString());
      //var itemCount = jsonResponse['totalItems'];
      //print('Number of books about http: $itemCount.');

      DateTime now = DateTime.now();
      int hora = now.hour;

      return jsonHourly['temperature_2m'][hora];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return 0;
    }
  }

}