import 'package:flutter/material.dart';
import 'package:myfarm/modal/table.dart';

class Farm extends Tables {
  int id;
  String name;
  int numH, numW;

  Farm(
      {@required this.name,
      @required this.numH,
      @required this.numW,
      this.id}) {
    this.tableName = "Farm";
  }

  Map<String, Object> toMap() {
    var map = {'name': name, 'numH': numH, 'numW': numW};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static fromMap(Map<String, Object> mapObj) {
    return new Farm(
        name: mapObj['name'],
        numH: mapObj['numH'],
        numW: mapObj['numW'],
        id: mapObj['id']);
  }
}
