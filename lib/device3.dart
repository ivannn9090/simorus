// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simorus/global_var.dart' as global;
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'dart:async';

class Device3 extends StatefulWidget
{
  @override
  Device3State createState() => Device3State();
}

class Device3State extends State<Device3>
{
  Timer? timer;
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) => updateValue());
  }
  void updateValue() async{
    var url = Uri.parse(global.endpoint + "Device3");
    final response = await http.get(url);
    if (response.statusCode == 200) {
        final data = jsonDecode(response.body)[0];
        setState(() {
          global.humidity3 = data['humidity3'];
          global.temperature3 = data['temperature3'];
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        timer?.cancel();
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Device 3",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text('Humidity 3', style: TextStyle(color: Colors.blueAccent)),
                      Text(global.humidity3 + ' %', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 28.0))
                    ],
                  ),
                  Material
                  (
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.water_damage_outlined, color: Colors.white, size: 30.0),
                      )
                    )
                  )
                ]
              ),
            ),
          ),
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text('Temperature 3', style: TextStyle(color: Colors.blueAccent)),
                      Text(global.temperature3 + ' °C', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 28.0))
                    ],
                  ),
                  Material
                  (
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.thermostat, color: Colors.white, size: 30.0),
                      )
                    )
                  )
                ]
              ),
            ),
          ),

        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 110.0),
        ],
      )
    ),
    );
  }

  Widget _buildTile(Widget child, {Function() ?onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell
      (
        // Do onTap() if it isn't null, otherwise do print()
        onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
        child: child
      )
    );
  }
}