
import 'package:flutter/material.dart';
import 'package:myfarm/shared/shared.dart';



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



Widget activityItem(){
  return GestureDetector(
    onTap: (){print('tapeed');},
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
                  Text(10.toString() + " "),
                  Text(1.toString() + " "),
                  Text(2020.toString()+ " "),
                ],
              ),
            ),
          ),
          Expanded(
            child: Text("سقاية" ,
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: green,
                  fontSize: 30.0
              ),),
          ),
        ],
      ),
    ),
  );
}