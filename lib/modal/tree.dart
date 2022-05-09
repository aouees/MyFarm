import 'package:flutter/material.dart';
import 'package:myfarm/modal/table.dart';

class Tree extends Tables {
  String type, note;
  int indexW, indexH, farmId,id;

  Tree({@required this.type,
      @required this.indexH,
      @required this.indexW,
      @required this.note,
      @required this.farmId,
      this.id}) {
    this.tableName = "Tree";
  }

  Map<String, Object> toMap() {
    var map = {
      'indexW': indexW,
      'indexH': indexH,
      'type': type,
      'note': note,
      'farmId': farmId,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static fromMap(Map<String, Object> mapObj) {
    return new Tree(
        type: mapObj['type'],
        indexH: mapObj['indexH'],
        indexW: mapObj['indexW'],
        note: mapObj['note'],
        farmId: mapObj['farmId'],
      id: mapObj['id']
    );
  }
}
