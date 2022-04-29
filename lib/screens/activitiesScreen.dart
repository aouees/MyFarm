import 'package:flutter/material.dart';
import 'package:myfarm/components/reusable_components.dart';
import 'package:myfarm/shared/shared.dart';

class activitiesScreen extends StatefulWidget {
 final String farmName;

  activitiesScreen({ this.farmName});

  @override
  State<activitiesScreen> createState() =>
      _activitiesScreenState(farmName: farmName);
}

class _activitiesScreenState extends State<activitiesScreen> {
  final  String farmName;

  _activitiesScreenState({ this.farmName});

  var scaffoldActivitiesKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var shown = false;
  var fabIcon = Icons.add;
  var fabText = 'جديد';
  TextEditingController name = new TextEditingController(),
      date = new TextEditingController(),
      cost = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldActivitiesKey,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          '$farmName',
          style: TextStyle(fontSize: 30.0),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(blurRadius: 30.0, color: brown, spreadRadius: 10.0)
            ],
            color: green,
            borderRadius: new BorderRadius.only(
                bottomRight: new Radius.elliptical(
                    MediaQuery.of(context).size.width, 100.0),
                bottomLeft: new Radius.elliptical(
                    MediaQuery.of(context).size.width, 100.0)),
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height / 7.0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.separated(
            itemBuilder: (context, index) => activityItem(),
            separatorBuilder: (context, index) => Divider(
                  thickness: 5,
                  height: 30,
                  color: brown.withOpacity(0.2),
                ),
            itemCount: 10),
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
                print('sdaadsd');
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
                            validator: (value) => value.isEmpty?'لا يمكن ترك حقل الاسم فارغ ' : null,
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
                                    borderSide:
                                    BorderSide(width: 2.0, color: brown)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3.0, color: green))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) => value.isEmpty ?'لا يمكن ترك حقل تاريخ النشاط فارغ ' : null ,
                            controller: date,
                            cursorColor: green,
                            keyboardType: TextInputType.datetime,
                            textDirection: TextDirection.rtl,
                            onTap: (){
                              showDatePicker(context: context,
                                  initialDate: DateTime.now(), 
                                  firstDate: DateTime(2000,1,1),
                                  lastDate: DateTime.now())
                                  .then((value) {
                                    date.text=value.year.toString()
                                        +"-"+value.month.toString()
                                        +'-'+value.day.toString();
                              });
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: 'تاريخ النشاط',
                                hintStyle: TextStyle(color: green),
                                hintTextDirection: TextDirection.rtl,
                                focusColor: green,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 2.0, color: brown)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3.0, color: green))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator:(value) => value.isEmpty ?'لا يمكن ترك حقل التكلفة فارغ ' : value.contains('-') ||
                                value.contains('.') ?  'لا يمكن ادخال رقم سالب او ذو فواصل' : null ,
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
                                    borderSide:
                                    BorderSide(width: 2.0, color: brown)),
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
                  .then((value) => {
                setState(() {
                  fabIcon = Icons.add;
                  fabText = 'جديد';
                  shown = false;
                }),
                if (formKey.currentState.validate()) {print('sdaadsd')}
              });
            }
          },
        ),
      ),
    );
  }
}
