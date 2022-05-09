import 'package:flutter/material.dart';

import '../shared/values.dart';

Widget myAppBar(context, title) {
  return AppBar(
    elevation: 0.0,
    automaticallyImplyLeading: true,
    backgroundColor: Colors.transparent,
    title: Text(
      title,
      style: TextStyle(fontSize: 40.0),
    ),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        boxShadow: [
          new BoxShadow(blurRadius: 30.0, color: brown, spreadRadius: 10.0)
        ],
        color: green,
        borderRadius: new BorderRadius.only(
            bottomRight:
                new Radius.elliptical(MediaQuery.of(context).size.width, 100.0),
            bottomLeft: new Radius.elliptical(
                MediaQuery.of(context).size.width, 100.0)),
      ),
    ),
    toolbarHeight: MediaQuery.of(context).size.height / 7.0,
  );
}
