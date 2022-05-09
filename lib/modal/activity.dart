import 'package:flutter/material.dart';
import 'package:myfarm/modal/table.dart';

class Activity extends Tables {
  String note, name, actDate;
  int farmId, id, type;
  double cost;

  //type is 1 => مقبوضات | true
  //type is 0 => مدفوعات | false

  Activity(
      {@required this.type,
      @required this.name,
      @required this.actDate,
      @required this.note,
      @required this.cost,
      @required this.farmId,
      this.id}) {
    this.tableName = "Activity";
  }

  Map<String, Object> toMap() {
    var map = {
      'name': name,
      'actDate': actDate,
      'cost': cost,
      'type': type,
      'note': note,
      'farmId': farmId,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static fromMap(Map <String ,Object> mapObj){
    return Activity(
        type:mapObj['type'],
        name: mapObj['name'],
        actDate: mapObj['actDate'],
        note: mapObj['note'],
        cost:  mapObj['cost'],
        farmId: mapObj['farmId'],
        id:mapObj['id']
    );
  }
}
