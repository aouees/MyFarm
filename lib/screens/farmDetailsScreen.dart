import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfarm/reused/reuesed.dart';
import 'package:myfarm/shared/values.dart';

import '../modal/farm.dart';
import '../modal/tree.dart';

class farmDetailsScreen extends StatefulWidget {
  Farm farm;

  farmDetailsScreen(this.farm);

  @override
  State<farmDetailsScreen> createState() => _farmDetailsScreenState();
}

class _farmDetailsScreenState extends State<farmDetailsScreen> {
  _farmDetailsScreenState();

  @override
  Widget build(BuildContext context) {
    String farmName = widget.farm.name;
    int x = widget.farm.numW, y = widget.farm.numH;
    return Scaffold(
        appBar: myAppBar(context, farmName),
        body: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: (y) * 85.0,
                  child: ListView.builder(
                      itemCount: x,
                      itemBuilder: (context, row) => Row(
                              children: List.generate(y, (col) {
                            return tree(treeList[y * row + col], context);
                          }))),
                ),
              ),
            ),
          ],
        ));
  }

  Widget tree(Tree tree, context) {
    String pos = "(${tree.indexW + 1},${tree.indexH + 1})";
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            barrierColor: brown.withOpacity(0.5),
            builder: (context) => AlertDialog(
                  content: Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      child: treeDetials(tree, context)),
                  elevation: 50.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: brown, width: 5.0),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ));
      },
      child: Container(
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
                Text(pos),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget treeDetials(Tree tree, context) {
    TextEditingController type = new TextEditingController(text: tree.type),
        note = new TextEditingController(text: tree.note);
    String pos = "(${tree.indexW + 1},${tree.indexH + 1})";
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: brown,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: green,
              radius: 47,
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.tree,
                  size: 50,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            pos,
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: green),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: type,
            cursorColor: green,
            keyboardType: TextInputType.text,
            textDirection: TextDirection.rtl,
            maxLength: 30,
            decoration: InputDecoration(
                hintText: 'نوع الشجرة : ',
                hintStyle: TextStyle(color: green),
                hintTextDirection: TextDirection.rtl,
                focusColor: green,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: brown),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3.0, color: green),
                    borderRadius: BorderRadius.all(Radius.circular(30)))),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: note,
            cursorColor: green,
            keyboardType: TextInputType.text,
            textDirection: TextDirection.rtl,
            maxLines: 4,
            minLines: 2,
            decoration: InputDecoration(
                hintText: 'ملاحظات :',
                hintStyle: TextStyle(color: green),
                hintTextDirection: TextDirection.rtl,
                focusColor: green,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: brown),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3.0, color: green),
                    borderRadius: BorderRadius.all(Radius.circular(30)))),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: brown, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(75))),
            child: TextButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.save_outlined,
                    size: 40,
                    color: green,
                  ),
                  Text(
                    'احفظ',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: green,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onPressed: () {
                myDatabase
                    .updateMyDatabase(
                        new Tree(
                            type: type.text,
                            indexH: tree.indexH,
                            indexW: tree.indexW,
                            note: note.text,
                            farmId: tree.farmId),
                        tree.id)
                    .then((value) async {
                  treeList = [];
                  var list =
                      await myDatabase.getTreesData(farmId: widget.farm.id);
                  list.forEach((element) {
                    Tree t = Tree.fromMap(element);
                    treeList.add(t);
                  });
                }).then((value) {
                  setState(() {});
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
