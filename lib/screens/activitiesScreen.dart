import 'package:flutter/material.dart';
import 'package:myfarm/modal/activity.dart';
import 'package:myfarm/modal/farm.dart';
import 'package:myfarm/reused/reuesed.dart';
import 'package:myfarm/shared/values.dart';

class activitiesScreen extends StatefulWidget {
  final Farm farm;

  activitiesScreen(this.farm);

  @override
  State<activitiesScreen> createState() => _activitiesScreenState();
}

class _activitiesScreenState extends State<activitiesScreen> {
  var scaffoldActivitiesKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var shown = false;
  var fabIcon = Icons.add;
  var fabText = 'جديد';
  var type = false;
  TextEditingController name = new TextEditingController(),
      actDate = new TextEditingController(),
      note = new TextEditingController(),
      cost = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldActivitiesKey,
      appBar: myAppBar(context, widget.farm.name),
      body: activityList.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'اضغط على زر "جديد +" ادناه لاضافة نشاط جديد',
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
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      activityItem(context, activityList[index]),
                  separatorBuilder: (context, index) => Divider(
                        thickness: 5,
                        height: 30,
                        color: brown.withOpacity(0.2),
                      ),
                  itemCount: activityList.length),
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
                setState(() {
                  fabIcon = Icons.add;
                  fabText = 'جديد';
                  shown = false;
                });
                myDatabase
                    .insertToMyDatabase(new Activity(
                  type: type ? 1 : 0,
                  name: name.text,
                  actDate: actDate.text,
                  note: note.text,
                  cost: double.parse(cost.text),
                  farmId: widget.farm.id,
                ))
                    .then((value) async {
                  activityList = [];
                  var list = await myDatabase.getActivitiesData(
                      farmId: widget.farm.id);
                  if (list != null) {
                    list.forEach((element) {
                      activityList.add(Activity.fromMap(element));
                    });
                  }
                }).then((value) {
                  setState(() {});
                });
                formKey.currentState.reset();
                Navigator.pop(context);
              }
            } else {
              setState(() {
                fabText = 'احفظ';
                fabIcon = Icons.save_outlined;
                shown = true;
              });
              scaffoldActivitiesKey.currentState
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
                                'اضافة نشاط جديد',
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
                                    hintText: 'اسم النشاط',
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
                                    ? 'لا يمكن ترك حقل تاريخ النشاط فارغ '
                                    : null,
                                controller: actDate,
                                cursorColor: green,
                                keyboardType: TextInputType.datetime,
                                textDirection: TextDirection.rtl,
                                onTap: () {
                                  showDatePicker(
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary:
                                                      green, // body text color
                                                ),
                                                textButtonTheme:
                                                    TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        green, // button text color
                                                  ),
                                                ),
                                              ),
                                              child: child,
                                            );
                                          },
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000, 1, 1),
                                          lastDate: DateTime.now())
                                      .then((value) {
                                    if (value != null) {
                                      actDate.text = value.year.toString() +
                                          "-" +
                                          value.month.toString() +
                                          '-' +
                                          value.day.toString();
                                    }
                                  });
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: 'تاريخ النشاط',
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
                                    ? 'لا يمكن ترك حقل التكلفة فارغ '
                                    : value.contains('-') || value.contains('.')
                                        ? 'لا يمكن ادخال رقم سالب او ذو فواصل'
                                        : null,
                                controller: cost,
                                cursorColor: green,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: false, decimal: false),
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                    hintText: 'التكلفة',
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
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                    hintText: '        نوع النشاط',
                                    hintStyle: TextStyle(color: green),
                                    hintTextDirection: TextDirection.rtl,
                                    focusColor: green,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2.0, color: brown)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3.0, color: green))),
                                icon:
                                    Icon(Icons.arrow_drop_down_circle_outlined),
                                elevation: 30,
                                iconEnabledColor: green,
                                onChanged: (value) => type = value,
                                items: [
                                  DropdownMenuItem(
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text('    المدفوعات')),
                                    value: false,
                                  ),
                                  DropdownMenuItem(
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text('    المقبوضات')),
                                    value: true,
                                  ),
                                ],
                                isExpanded: true,
                                validator: (var value) {
                                  if (value == null)
                                    return 'لا يمكن ترك حقل النوع فارغ ';
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (value) => value.isEmpty
                                    ? 'لا يمكن ترك حقل الملاحظات فارغ '
                                    : null,
                                controller: note,
                                cursorColor: green,
                                maxLines: 3,
                                minLines: 1,
                                keyboardType: TextInputType.text,
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                    hintText: 'ملاحظات',
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
                              // Row(
                              //   children: [
                              //     Radio(value: true, groupValue: type, onChanged: (value){setState(() {type=value;});}, ),
                              //     Radio(value: false, groupValue: type, onChanged: (value){setState(() {type=value;});},),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .closed
                  .then((value) => {
                        setState(() {
                          fabIcon = Icons.add;
                          fabText = 'جديد';
                          shown = false;
                        }),
                      });
            }
          },
        ),
      ),
    );
  }

  Widget activityItem(context, Activity activity) {
    List<String> dateAsString = activity.actDate.split('-');
    return GestureDetector(
      onTap: () {
        showDialog(
            barrierColor: brown.withOpacity(0.5),
            context: context,
            builder: (context) => AlertDialog(
                  content: Container(
                      margin: EdgeInsets.all(10),
                      child: activityItemDetiles(activity)),
                  elevation: 50.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: brown, width: 5.0),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ));
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: brown, width: 5.0),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: brown,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: green,
                radius: 45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(dateAsString[2]),
                    Text(dateAsString[1]),
                    Text(dateAsString[0]),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Text(
                "${activity.name}",
                maxLines: 1,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: green, fontSize: 30.0),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            IconButton(
                icon: Icon(
                  Icons.delete_forever_outlined,
                  size: 35,
                  color: brown,
                ),
                onPressed: () async {
                  await myDatabase
                      .deleteFromMyDatabase(activity, activity.id)
                      .then((value) async {
                    activityList = [];
                    var list = await myDatabase.getActivitiesData(
                        farmId: widget.farm.id);
                    if (list != null) {
                      list.forEach((element) {
                        activityList.add(Activity.fromMap(element));
                      });
                    }
                  });
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }

  Widget activityItemDetiles(Activity activity) {
    List<String> dateAsString = activity.actDate.split('-');

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
              radius: 45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(dateAsString[2]),
                  Text(dateAsString[1]),
                  Text(dateAsString[0]),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${activity.name} ',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                'اسم النشاط : ',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: 25, color: green, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(
            thickness: 3,
            height: 10,
            color: brown.withOpacity(0.6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${activity.cost} ',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'التكلفة : ',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 25, color: green),
              ),
            ],
          ),
          Divider(
            thickness: 3,
            height: 10,
            color: brown.withOpacity(0.6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                activity.type == 1 ? 'مقبوضات' : 'مدفوعات',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'نوع النشاط : ',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 25, color: green),
              ),
            ],
          ),
          Divider(
            thickness: 3,
            height: 10,
            color: brown.withOpacity(0.6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: Text(
                ' ${activity.note} ',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 20),
                softWrap: true,
                overflow: TextOverflow.visible,
              )),
              Text(
                'ملاحظات : ',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 25, color: green),
              ),
            ],
          ),
          Divider(
            thickness: 3,
            height: 10,
            color: brown.withOpacity(0.6),
          ),
        ],
      ),
    );
  }
}
