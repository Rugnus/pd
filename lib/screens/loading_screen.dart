import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '0fef488560ab5706a17869e15ac347e3';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude;
  double longitude;

  @override
  void initState() {

    super.initState();
    getLocation();
    print('TRIGGER!!!');

  }

  void getLocation() async{

    Location location = Location();
    await location.getCurrentLocation();
    latitude =location.latitude;
    longitude =location.longitude;

    getData();

  }

  void getData() async{
    http.Response response = await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    if (response.statusCode == 200) {
        String data = response.body;

        var decodedData = jsonDecode(data);

        int weatherCondition = decodedData['weather'][0]['id'];

        double weatherTemperature = decodedData['main']['temp'];
        
        String weatherCity = decodedData['name'];


        print(weatherTemperature);
        print(weatherCondition);
        print(weatherCity);

    } else {
      print( response.statusCode);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
