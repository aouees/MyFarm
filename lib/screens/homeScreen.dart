import 'package:flutter/material.dart';

class HomesScreen extends StatefulWidget {
  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF33a02b),
        title: Text("مزرعتي"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF33a02b), width: 2.0)),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF33a02b), width: 2.0)),
                  child: TextButton(
                    onPressed: () {},
                    child: Text (
                      "عرض الانشطة",
                      softWrap: true,
                      style: TextStyle(
                        color: Color(0xFF33a02b),
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF33a02b), width: 2.0)),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "عرض التقارير",
                      softWrap: true,
                      style: TextStyle(
                        color: Color(0xFF33a02b),
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
