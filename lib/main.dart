import 'package:flutter/material.dart';
import 'package:simorus/device1.dart';
import 'package:simorus/device2.dart';
import 'package:simorus/device3.dart';
import 'package:simorus/device4.dart';
import 'package:simorus/global_var.dart' as global;
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'dart:async';
import 'notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() {
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIMORUS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'SIMORUS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Timer? timer;
  int counter = 0;
  int idNotif = 0;

  @override
  void initState() {
    super.initState();
    notif.initialize(flutterLocalNotificationsPlugin);
    timer = Timer.periodic(Duration(milliseconds: 1000), (Timer t) => updateValue());
  }

  void updateValue() async{
    var url = Uri.parse(global.endpoint + "Devicestatus");
    final response = await http.get(url);
    if (response.statusCode == 200) {
        final data = jsonDecode(response.body)[0];

        if(global.temperature1State != data['temperature1']){
          if(data['temperature1'] == "Suhu Berlebihan"){
            notif.showNotif(id: idNotif, body: "Temperature 1 : " + data['temperature1'], fln: flutterLocalNotificationsPlugin);
            setState(() {idNotif++;});
          }
        }
        if(global.temperature2State != data['temperature2']){
          if(data['temperature2'] == "Suhu Berlebihan"){
            notif.showNotif(id: idNotif, body: "Temperature 2 : " + data['temperature2'], fln: flutterLocalNotificationsPlugin);
            setState(() {idNotif++;});
          }
        }
        if(global.temperature3State != data['temperature3']){
          if(data['temperature3'] == "Suhu Berlebihan"){
            notif.showNotif(id: idNotif, body: "Temperature 3 : " + data['temperature3'], fln: flutterLocalNotificationsPlugin);
            setState(() {idNotif++;});
          }
        }

        if(global.fire1State != data['fire1']){
          if(data['fire1'] == "Api Terdeteksi"){
            notif.showNotif(id: idNotif, body: "Fire 1 : " + data['fire1'], fln: flutterLocalNotificationsPlugin);
            setState(() {idNotif++;});
          }
        }
        if(global.fire2State != data['fire2']){
          if(data['fire2'] == "Api Terdeteksi"){
            notif.showNotif(id: idNotif, body: "Fire 2 : " + data['fire2'], fln: flutterLocalNotificationsPlugin);
            setState(() {idNotif++;});
          }
        }

        if(global.smoke1State != data['smoke1']){
          if(data['smoke1'] == "Asap Terdeteksi"){
            notif.showNotif(id: idNotif, body: "Smoke 1 : " + data['smoke1'], fln: flutterLocalNotificationsPlugin);
            setState(() {idNotif++;});
          }
        }
        if(global.smoke2State != data['smoke2']){
          if(data['smoke2'] == "Asap Terdeteksi"){
            notif.showNotif(id: idNotif, body: "Smoke 2 : " + data['smoke2'], fln: flutterLocalNotificationsPlugin);
            setState(() {idNotif++;});
          }
        }
        if(global.movement1State != data['movement1']){
          if(data['movement1'] == "Ada Gerakan"){
            notif.showNotif(id: idNotif, body: "Movement 1 : " + data['movement1'], fln: flutterLocalNotificationsPlugin);
            setState(() {idNotif++;});
          }
        }


        setState(() {
          global.temperature1State = data['temperature1'];
          global.temperature2State = data['temperature2'];
          global.temperature3State = data['temperature3'];
          global.fire1State = data['fire1'];
          global.fire2State = data['fire2'];
          global.smoke1State = data['smoke1'];
          global.smoke2State = data['smoke2'];
          global.movement1State = data['movement1'];
        });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.width / 15),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Device1();
                      }),
                    );
                  },
                  child: Text(
                    "Device 1",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: MediaQuery.of(context).size.width / 23,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 15),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Device2();
                      }),
                    );
                  },
                  child: Text(
                    "Device 2",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: MediaQuery.of(context).size.width / 23,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 15),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Device3();
                      }),
                    );
                  },
                  child: Text(
                    "Device 3",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: MediaQuery.of(context).size.width / 23,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 15),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Device4();
                      }),
                    );
                  },
                  child: Text(
                    "Device 4",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: MediaQuery.of(context).size.width / 23,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 15),
            ],
          ),
        ),
      ],
    ),
    );
  }
}
