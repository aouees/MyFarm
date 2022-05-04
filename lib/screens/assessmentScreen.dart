import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myfarm/modal/structures.dart';
import '../shared/values.dart';

class assessmentScreen extends StatefulWidget {
  final String farmName;

  assessmentScreen(this.farmName);

  @override
  State<assessmentScreen> createState() => _assessmentScreenState();
}

class _assessmentScreenState extends State<assessmentScreen> {
  List<data> datalist = List.generate(
      22,
      (index) => data(2000 + index, Random().nextInt(5) * 1000000 + 1000000,
          Random().nextInt(5) * 1000000 + 1000000));
  List<BarChartGroupData> BarGroups = [];

  @override
  void initState() {
    super.initState();
    for (data d in datalist) {
      BarGroups.add(makeGroupData(d));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.farmName,
          style: TextStyle(fontSize: 25.0),
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(blurRadius: 30.0, color: brown, spreadRadius: 10.0)
            ],
            color: green,
            borderRadius: new BorderRadius.only(
                bottomRight: new Radius.elliptical(
                    MediaQuery.of(context).size.width, 100.0),
                bottomLeft: new Radius.elliptical(
                    MediaQuery.of(context).size.width, 100.0)),
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height / 7.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: BarGroups.length * 100.0,
                padding: EdgeInsets.only(top: 60, left: 10, bottom: 10),
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: BarGroups,
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) => Text(
                              value.toInt().toString(),
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 50,
                          showTitles: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '   المدفوعات  ',
                style: TextStyle(fontSize: 20),
              ),
              CircleAvatar(
                backgroundColor: green,
                radius: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '   المقبوضات  ',
                style: TextStyle(fontSize: 20),
              ),
              CircleAvatar(
                backgroundColor: brown,
                radius: 10,
              ),
            ],
          )
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(data d) {
    return BarChartGroupData(barsSpace: 7, x: d.year, barRods: [
      BarChartRodData(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(45), topLeft: Radius.circular(45)),
        toY: d.ex * 1.0,
        color: green,
        width: 15,
      ),
      BarChartRodData(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(45), topLeft: Radius.circular(45)),
        toY: d.ix * 1.0,
        color: brown,
        width: 15,
      ),
    ]);
  }
}
