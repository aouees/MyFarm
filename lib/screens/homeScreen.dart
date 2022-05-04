import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myfarm/components/reusable_components.dart';
import 'package:myfarm/shared/values.dart';

class HomesScreen extends StatefulWidget {
  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var shown = false;
  var fabIcon = Icons.add;
  var fabText = 'جديد';
  TextEditingController name = new TextEditingController(),
      numH = new TextEditingController(),
      numW = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'مزرعتي',
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
                bottomRight: new Radius.elliptical(
                    MediaQuery.of(context).size.width, 100.0),
                bottomLeft: new Radius.elliptical(
                    MediaQuery.of(context).size.width, 100.0)),
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height / 7.0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
        alignment: Alignment.center,
        height: 250,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return farmItem();
          },
          viewportFraction: 0.85,
          itemCount: 10,
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
                setState(() {
                  fabIcon = Icons.add;
                  fabText = 'جديد';
                  shown = false;
                });
                print('sdaadsd');
                Navigator.pop(context);

              }
            }
            else {
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
                                validator: (value) => value.isEmpty?'لا يمكن ترك حقل الاسم فارغ ' : null,
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
                                validator: (value) => value.isEmpty ?'لا يمكن ترك حقل عدد الاشجار طولا فارغ ' : value.contains('-') ||
                                    value.contains('.') ?  'لا يمكن ادخال رقم سالب او ذو فواصل' : null ,
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
                                validator:(value) => value.isEmpty ?'لا يمكن ترك حقل عدد الاشجار عرضا فارغ ' : value.contains('-') ||
                                    value.contains('.') ?  'لا يمكن ادخال رقم سالب او ذو فواصل' : null ,
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
