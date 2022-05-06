
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfarm/shared/values.dart';



Widget farmItem(){
  return InkWell(
    onTap: (){},
    child: Container(

      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color:brown, width: 5.0),
          borderRadius:  BorderRadius.only(topRight:  Radius.circular(75) ,bottomLeft: Radius.circular(75) ) ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Text("المزرعة الشمالية الشرقية" ,
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: green,
                fontSize: 30.0
            ),),
          Text("5 × 20 = 100" ,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color:green,
                fontSize: 25.0
            ),),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                tooltip: 'حذف المزرعة',
                iconSize: 50.0,
                onPressed: () {},
                color:green,
                splashRadius: 50.0,
                icon:Icon( Icons.delete_forever_outlined,),
              ),
              IconButton(
                tooltip: 'تعديل بيانات المزرعة',
                iconSize:  50.0,
                onPressed: () {},
                color: green,
                splashRadius: 50.0,
                icon:Icon( Icons.edit_outlined),
              ),
              IconButton(
                tooltip: 'انشطة المزرعة',
                iconSize:  50.0,
                onPressed: () {},
                color:green,
                splashRadius: 50.0,
                icon:Icon( Icons.assignment_outlined,),
              ),
              IconButton(
                tooltip: 'تقارير المزرعة',
                iconSize: 50.0,
                onPressed: () {},
                color:green,
                splashRadius: 50.0,
                icon:Icon( Icons.assessment_outlined,),
              ),
            ],
          ),

        ],
      ),
    ),
  );
}


Widget activityItem(context, name){
  return GestureDetector(
    onTap: (){
      showDialog(
          barrierColor: brown.withOpacity(0.5),
          context: context,
          builder: (context) => AlertDialog(
            content: Container(
              margin: EdgeInsets.all(10),
                child: activityItemDetiles()) ,
            elevation: 50.0,
            shape: RoundedRectangleBorder(
              side:  BorderSide(color:brown, width: 5.0),
              borderRadius: BorderRadius.all( Radius.circular(50)),
            ),
          )
      );
    },
    child: Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color:brown, width: 5.0),
          borderRadius:  BorderRadius.all( Radius.circular(30)),
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
                  Text(5.toString() + " "),
                  Text(5.toString() + " "),
                  Text(2022.toString()+ " "),
                ],
              ),
            ),
          ),
          Expanded(
            child: Text("$name" ,
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: green,
                  fontSize: 30.0
              ),),
          ),
          SizedBox(width: 5,),
          IconButton(icon: Icon(Icons.delete_forever_outlined ,size: 35,color: brown, ), onPressed: (){})
        ],
      ),
    ),
  );
}


Widget activityItemDetiles(){

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
                Text(5.toString() + " "),
                Text(5.toString() + " "),
                Text(2022.toString()+ " "),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('سقاية ' ,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25 ,fontWeight: FontWeight.bold),),
            Text('اسم النشاط : ' ,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25,color: green ,fontWeight: FontWeight.bold),),
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
            Text('50000 ' ,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20),),
            Text('التكلفة : ' ,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25,color: green),),
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
            Text('مدفوعات ' ,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20),),
            Text('نوع النشاط : ' ,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25,color: green),),
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
            Expanded(child: Text(' تم تسليمها للعامل محمد واحمد ' ,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20),softWrap: true,overflow: TextOverflow.visible,)),
            Text('ملاحظات : ' ,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25,color: green),),
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


Widget tree(int z,int y,context) {
  String x="($z,$y)";
  return InkWell(
    onTap: (){
      showDialog(
          context: context,
          barrierColor: brown.withOpacity(0.5),
          builder: (context) => AlertDialog(
            content: Container(
                margin: EdgeInsets.all(10),
                child: treeDetials(z, y,context)) ,
            elevation: 50.0,
            shape: RoundedRectangleBorder(
              side:  BorderSide(color:brown, width: 5.0),
              borderRadius: BorderRadius.all( Radius.circular(50)),
            ),
          )
      );
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
              Text(x),

            ],
          ),
        ),
      ),
    ),
  )

  ;
}


Widget treeDetials(int z,int y,context){
  TextEditingController type = new TextEditingController(),
            note=new TextEditingController();
  String x="($z,$y)";
  return  SingleChildScrollView(
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
            child:  Center(child: FaIcon(FontAwesomeIcons.tree ,size: 50,),),
          ),
        ),
        SizedBox(height: 10,),
        Text(x ,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25 ,fontWeight: FontWeight.bold , color: green),textAlign: TextAlign.center,),
        SizedBox(height: 10,),
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
                  borderSide:
                  BorderSide(width: 2.0, color: brown),
                  borderRadius: BorderRadius.all(Radius.circular(30))

              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3.0, color: green),
                  borderRadius: BorderRadius.all(Radius.circular(30)
                  )
              )

          ),
        ),
        SizedBox(height: 10,),
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
                  borderSide:
                  BorderSide(width: 2.0, color: brown),
                borderRadius: BorderRadius.all(Radius.circular(30))
              
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3.0, color: green),
                  borderRadius: BorderRadius.all(Radius.circular(30)
                  )
              )
          ),
        ),
        SizedBox(height: 10,),
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
                    fontSize: 20.0, color: green, fontWeight: FontWeight.bold),
              )
            ],
      ),
            onPressed: (){

              Navigator.of(context).pop();
            },
    ),
        ),


      ],
    ),
  );
}


