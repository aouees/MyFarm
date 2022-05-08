import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:myfarm/modal/farm.dart';
import 'package:myfarm/modal/structures.dart';
import 'package:myfarm/modal/tree.dart';
import 'package:myfarm/reused/reuesed.dart';
import 'package:myfarm/screens/activitiesScreen.dart';
import 'package:myfarm/screens/assessmentScreen.dart';
import 'package:myfarm/screens/farmDetailsScreen.dart';
import 'package:myfarm/shared/database.dart';
import 'package:myfarm/shared/values.dart';

import '../modal/activity.dart';

class HomesScreen extends StatefulWidget {
  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var newFormKey = GlobalKey<FormState>();
  var shown = false;
  var fabIcon = Icons.add;
  var fabText = 'جديد';
  List<Farm> farmsList = [];
  TextEditingController name = new TextEditingController(),
      numH = new TextEditingController(),
      numW = new TextEditingController(),
      new_name = new TextEditingController();

  @override
  void initState() {
    super.initState();
    myDatabase = new MyDatabase();
    myDatabase.openMyDatabase().then((value) async {
      farmsList = [];
      var tempList = await myDatabase.getFarmsData();
      if (tempList != null) {
        tempList.forEach((element) {
          farmsList.add(Farm.fromMap(element));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: myAppBar(context, 'مزرعتي'),
      body: farmsList.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'اضغط على زر "جديد +" ادناه لاضافة مزرعة جديدة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          : Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
              alignment: Alignment.center,
              height: 250,
              child: Swiper(
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  return farmItem(farmsList[index], context);
                },
                viewportFraction: 0.85,
                itemCount: farmsList.length,
                scale: 0.9,
              ),
            ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: brown, width: 5.0),
            borderRadius: BorderRadius.all(Radius.circular(75))),
        child: TextButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                fabIcon,
                size: 40,
                color: green,
              ),
              Text(
                fabText,
                style: TextStyle(
                    fontSize: 20.0, color: green, fontWeight: FontWeight.bold),
              )
            ],
          ),
          onPressed: () {
            if (shown) {
              if (formKey.currentState.validate()) {
                myDatabase
                    .insertToMyDatabase(Farm(
                        name: name.text,
                        numH: int.parse(numH.text),
                        numW: int.parse(numW.text)))
                    .then((value) async {
                  farmsList = [];
                  var tempList = await myDatabase.getFarmsData();
                  if (tempList != null) {
                    tempList.forEach((element) {
                      farmsList.add(Farm.fromMap(element));
                    });
                  }
                }).then((value) {
                  setState(() {});
                });
                fabIcon = Icons.add;
                fabText = 'جديد';
                shown = false;
                Navigator.pop(context);
              }
            } else {
              setState(() {
                fabText = 'احفظ';
                fabIcon = Icons.save_outlined;
                shown = true;
              });
              scaffoldKey.currentState
                  .showBottomSheet(
                    (context) => Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                              blurRadius: 30.0,
                              color: brown,
                              spreadRadius: 10.0)
                        ],
                        border: Border.fromBorderSide(
                            BorderSide(width: 5.0, color: brown)),
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topRight: new Radius.elliptical(
                                MediaQuery.of(context).size.width, 100.0),
                            topLeft: new Radius.elliptical(
                                MediaQuery.of(context).size.width, 100.0)),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'اضافة مزرعة جديدة',
                                style: TextStyle(
                                    color: green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0),
                              ),
                              TextFormField(
                                validator: (value) => value.isEmpty
                                    ? 'لا يمكن ترك حقل الاسم فارغ '
                                    : null,
                                controller: name,
                                cursorColor: green,
                                keyboardType: TextInputType.text,
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                    hintText: 'اسم المزرعة',
                                    hintStyle: TextStyle(color: green),
                                    hintTextDirection: TextDirection.rtl,
                                    focusColor: green,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2.0, color: brown)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3.0, color: green))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (value) => value.isEmpty
                                    ? 'لا يمكن ترك حقل عدد الاشجار طولا فارغ '
                                    : value.contains('-') || value.contains('.')
                                        ? 'لا يمكن ادخال رقم سالب او ذو فواصل'
                                        : null,
                                maxLength: 2,
                                controller: numH,
                                cursorColor: green,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: false, decimal: false),
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                    hintText: 'عدد الاشجار طولاً',
                                    hintStyle: TextStyle(color: green),
                                    hintTextDirection: TextDirection.rtl,
                                    focusColor: green,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2.0, color: brown)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3.0, color: green))),
                              ),
                              /* SizedBox(
                                height: 10,
                              ),*/
                              TextFormField(
                                validator: (value) => value.isEmpty
                                    ? 'لا يمكن ترك حقل عدد الاشجار عرضا فارغ '
                                    : value.contains('-') || value.contains('.')
                                        ? 'لا يمكن ادخال رقم سالب او ذو فواصل'
                                        : null,
                                controller: numW,
                                maxLength: 2,
                                cursorColor: green,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: false, decimal: false),
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                    hintText: 'عدد الاشجار عرضاً',
                                    hintStyle: TextStyle(color: green),
                                    hintTextDirection: TextDirection.rtl,
                                    focusColor: green,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2.0, color: brown)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3.0, color: green))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .closed
                  .then((value) {
                setState(() {
                  fabIcon = Icons.add;
                  fabText = 'جديد';
                  shown = false;
                });
              });
            }
          },
        ),
      ),
    );
  }

  Widget farmItem(Farm farm, context) {
    int t = farm.numW * farm.numH;
    return InkWell(
      onTap: () async {
        treeList = [];
        var list = await myDatabase.getTreesData(farmId: farm.id);
        list.forEach((element) {
          Tree t = Tree.fromMap(element);
          print(element);
          treeList.add(t);
        });
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => farmDetailsScreen(farm)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: brown, width: 5.0),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(75),
                bottomLeft: Radius.circular(75))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${farm.name}",
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: green, fontSize: 30.0),
            ),
            Text(
              "${farm.numW} × ${farm.numH} = $t",
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: green, fontSize: 25.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: 'حذف المزرعة',
                  iconSize: 50.0,
                  onPressed: () async {
                    await myDatabase.deleteFromMyDatabase(farm, farm.id);
                    farmsList = [];
                    var tempList = await myDatabase.getFarmsData();
                    if (tempList != null) {
                      tempList.forEach((element) {
                        farmsList.add(Farm.fromMap(element));
                      });
                    }
                    setState(() {});
                  },
                  color: green,
                  splashRadius: 50.0,
                  icon: Icon(
                    Icons.delete_forever_outlined,
                  ),
                ),
                IconButton(
                  tooltip: 'تعديل بيانات المزرعة',
                  iconSize: 50.0,
                  onPressed: () {
                    showDialog(
                        barrierColor: brown.withOpacity(0.5),
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Container(
                                margin: EdgeInsets.all(10),
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: newFormKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          validator: (value) => value.isEmpty
                                              ? 'لا يمكن ترك حقل الاسم فارغ '
                                              : null,
                                          controller: new_name,
                                          cursorColor: green,
                                          keyboardType: TextInputType.text,
                                          textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                              hintText: 'اسم المزرعة',
                                              hintStyle: TextStyle(
                                                  color: green),
                                              hintTextDirection: TextDirection
                                                  .rtl,
                                              focusColor: green,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 2.0,
                                                          color: brown)),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 3.0,
                                                          color: green))),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: brown, width: 5.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(75))),
                                          child: TextButton(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            onPressed: () async {
                                              if (newFormKey.currentState
                                                  .validate()) {
                                                farm.name = new_name.text;
                                                print(new_name.text);
                                                myDatabase.updateMyDatabase(
                                                    new Farm(
                                                        name: new_name.text,
                                                        numH: farm.numH,
                                                        numW: farm.numW),
                                                    farm.id);
                                                farmsList = [];
                                                var tempList = await myDatabase
                                                    .getFarmsData();
                                                if (tempList != null) {
                                                  tempList.forEach((element) {
                                                    farmsList.add(
                                                        Farm.fromMap(element));
                                                  });
                                                  setState(() {});
                                                  newFormKey.currentState
                                                      .reset();
                                                  Navigator.of(context).pop();
                                                }
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              elevation: 50.0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: brown, width: 5.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ));
                  },
                  color: green,
                  splashRadius: 50.0,
                  icon: Icon(Icons.edit_outlined),
                ),
                IconButton(
                  tooltip: 'انشطة المزرعة',
                  iconSize: 50.0,
                  onPressed: () async {
                    await myDatabase.doSomething().then((value) async {
                      activityList = [];
                      var list =
                          await myDatabase.getActivitiesData(farmId: farm.id);
                      if (list != null) {
                        list.forEach((element) {
                          activityList.add(Activity.fromMap(element));
                        });
                      }
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => activitiesScreen(farm)));
                  },
                  color: green,
                  splashRadius: 50.0,
                  icon: Icon(
                    Icons.assignment_outlined,
                  ),
                ),
                IconButton(
                  tooltip: 'تقارير المزرعة',
                  iconSize: 50.0,
                  onPressed: () async {
                    activityList = [];
                    var list =
                        await myDatabase.getActivitiesData(farmId: farm.id);
                    if (list != null) {
                      list.forEach((element) {
                        activityList.add(Activity.fromMap(element));
                      });
                    }
                    if (activityList.isNotEmpty) {
                      Map<String, double> ix = new Map(), ex = new Map();
                      activityList.forEach((element) {
                        String year = element.actDate.split('-')[0];

                        if (element.type == 1) {
                          if (ix[year] == null)
                            ix[year] = element.cost;
                          else
                            ix[year] += element.cost;
                        } else {
                          if (ex[year] == null)
                            ex[year] = element.cost;
                          else
                            ex[year] += element.cost;
                        }
                      });
                      dataList = [];
                      ix.keys.forEach((element) {
                        dataList.add(DataAct(
                            int.parse(element), ix[element], ex[element]));
                      });
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => assessmentScreen(farm.name)));
                  },
                  color: green,
                  splashRadius: 50.0,
                  icon: Icon(
                    Icons.assessment_outlined,
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
