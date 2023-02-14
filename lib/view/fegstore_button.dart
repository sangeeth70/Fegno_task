import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  String title;
  final GestureTapCallback ? onPressed;
   PrimaryButton({Key? key,required this.title,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: height/14,
        width: width-30,
        decoration: BoxDecoration(
          color:Color.fromARGB(255, 77,84,229,),
          borderRadius: BorderRadius.all(Radius.circular(14))
        ),
        child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18,),),
      ),
    );
  }
}


