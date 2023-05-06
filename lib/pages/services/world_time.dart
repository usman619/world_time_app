import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  String flag;
  String url; // use to concat with the actual url to make request
  late bool isDayTIme; // if True(day time) Else False(night time)

  WorldTime({required this.location, required this.flag, required this.url});

  // (Future): placeholder value until the function is complete
  Future<void> getTime() async {
    try {
      // Making the response to world-time API
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // Getting the properties from the data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // Creating a date-time object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTIme = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Error: $e');
      time = 'Could not the time data.';
    }
  }
}
