import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfarm/shared/shared.dart';

class farmDetailsScreen extends StatefulWidget {
  String farmName;
  int x, y;

  farmDetailsScreen(this.farmName, this.x, this.y);

  @override
  State<farmDetailsScreen> createState() => _farmDetailsScreenState();
}

class _farmDetailsScreenState extends State<farmDetailsScreen> {

  _farmDetailsScreenState();

  @override
  Widget build(BuildContext context) {
    String farmName = widget.farmName;
    print(widget.x.toString() + " " + widget.y.toString());
    int x = widget.x,
        y = widget.y;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(
            '$farmName',
            style: TextStyle(fontSize: 25.0),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                    blurRadius: 30.0, color: brown, spreadRadius: 10.0)
              ],
              color: green,
              borderRadius: new BorderRadius.only(
                  bottomRight: new Radius.elliptical(
                      MediaQuery
                          .of(context)
                          .size
                          .width, 100.0),
                  bottomLeft: new Radius.elliptical(
                      MediaQuery
                          .of(context)
                          .size
                          .width, 100.0)),
            ),
          ),
          toolbarHeight: MediaQuery
              .of(context)
              .size
              .height / 7.0,
        ),
        body: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: (x) * 85.0,
                  child: ListView.builder(
                      itemCount: y,
                      itemBuilder: (context, index) =>
                          Row(
                              children: List.generate(x, (b) {
                                var c = b + 1,
                                    d = index + 1;
                                return tree("($c,$d)");
                              }))), /*(
                    children: List.generate(y, (a) {
                      return Row(
                        children: List.generate(x, (b) {
                          var c = b + 1, d = a + 1;
                          return mybutton("($c,$d)");
                        }),
                      );
                    }),
                  ),*/
                ),
              ),
            ),
          ],
        ));
  }


  Widget tree(String x) {
    return Container(
      margin: EdgeInsets.all(2.5),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: brown,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: green,
          radius: 35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FaIcon(FontAwesomeIcons.tree),
              Text(x),
            ],
          ),
        ),
      ),
    )

    ;
  }
}
