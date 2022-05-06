import 'package:flutter/material.dart';
import 'package:myfarm/components/reusable_components.dart';
import 'package:myfarm/shared/values.dart';

class activitiesScreen extends StatefulWidget {
  final String farmName;

  activitiesScreen(this.farmName);

  @override
  State<activitiesScreen> createState() =>
      _activitiesScreenState();
}

class _activitiesScreenState extends State<activitiesScreen> {

  var scaffoldActivitiesKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var shown = false;
  var fabIcon = Icons.add;
  var fabText = 'جديد';
  var type = false;
  var ss=[ 'سقاية','قطاف', 'تقليم','بخ مبيدات حشرية'];
  TextEditingController name = new TextEditingController(),
      date = new TextEditingController(),
      note = new TextEditingController(),
      cost = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldActivitiesKey,
      appBar: AppBar(
        elevation: 0.0,
       // automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.farmName,
          style: TextStyle(fontSize: 25.0),
          softWrap: true,
            overflow: TextOverflow.ellipsis,
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
            itemBuilder: (context, index) => activityItem(context ,ss[index] ),
            separatorBuilder: (context, index) => Divider(
                  thickness: 5,
                  height: 30,
                  color: brown.withOpacity(0.2),
                ),
            itemCount: 4),
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
                                controller: date,
                                cursorColor: green,
                                keyboardType: TextInputType.datetime,
                                textDirection: TextDirection.rtl,
                                onTap: () {
                                  showDatePicker(
                                      builder: (context, child) {
                                        return Theme(

                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: green, // body text color
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: green, // button text color
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
                                        if(value != null){
                                    date.text = value.year.toString() +
                                        "-" +
                                        value.month.toString() +
                                        '-' +
                                        value.day.toString();}
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
                                icon: Icon(Icons.arrow_drop_down_circle_outlined),

                                elevation: 30,
                                iconEnabledColor: green,
                                onChanged: (value) => type =value,
                                  items: [
                                DropdownMenuItem(child: Container( alignment: Alignment.centerRight,child: Text('    المدفوعات')),value: false, ),
                                DropdownMenuItem(child: Container( alignment: Alignment.centerRight,child:  Text('    المقبوضات') ), value:  true,),
                              ],
                              isExpanded: true,

                              validator: (var value){
                                    if(value == null)
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
                                    :  null,
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
}
