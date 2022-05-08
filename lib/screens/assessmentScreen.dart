
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myfarm/modal/structures.dart';
import 'package:myfarm/reused/reuesed.dart';
import '../shared/values.dart';

class assessmentScreen extends StatefulWidget {
  final String farmName;

  assessmentScreen(this.farmName);

  @override
  State<assessmentScreen> createState() => _assessmentScreenState();
}

class _assessmentScreenState extends State<assessmentScreen> {
  List<BarChartGroupData> barGroups = [];

  @override
  void initState() {
    super.initState();
    if (dataList.isNotEmpty)
      for (DataAct d in dataList) {
        barGroups.add(makeGroupData(d));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, widget.farmName),
      body: dataList.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: barGroups.length * 100.0,
                      padding: EdgeInsets.only(top: 60, left: 10, bottom: 10),
                      child: BarChart(
                        BarChartData(
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: barGroups,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'اضف انشطة على هذه المزرعة لعرض الاحصائيات',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
    );
  }

  BarChartGroupData makeGroupData(DataAct d) {
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
