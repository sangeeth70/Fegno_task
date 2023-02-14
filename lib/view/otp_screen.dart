import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fegstore/BLoC/timer_cubit.dart';
import 'package:fegstore/BLoC/task_event.dart';
import 'package:fegstore/BLoC/task_state.dart';
import 'package:fegstore/view/fegstore_button.dart';
import 'package:fegstore/view/rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPVerification extends StatefulWidget {
  String number;
   OTPVerification({Key? key,required this.number}) : super(key: key);

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(_countdown != 0){
        setState(() {
          _countdown--;
        });
        // print(_countdown.toString());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Time Out!"))
        );
        timer.cancel();
      }
    });
    super.initState();
  }

  int _countdown = 30;
  late final _snackBar;
  final _value1 = TextEditingController();
  final _value2 = TextEditingController();
  final _value3 = TextEditingController();
  final _value4 = TextEditingController();
  late String contact;

  Future OtpVerificationMethod()async{
    try {
      var map = Map<dynamic, String>();
      map['mobile'] = widget.number.toString();
      map['otp'] = _value1.text + _value2.text + _value3.text + _value4.text;
      print(map);
      final response = await Dio().post(
          'https://blacksquad.dev.fegno.com/api/v1/user/enter_otp/',
          data: map, options: Options(headers: {
        'Accept': 'application/json'
      })
      );
        print(response.data);
      SharedPreferences sharedPreference = await SharedPreferences.getInstance();
      sharedPreference.setString('token', response.data['token'].toString());
      print({"Shared => ",sharedPreference.getString('token').toString()});
      Navigator.push(
            context, MaterialPageRoute(builder: (context) => RatingScreen()));
    } catch (err){
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP verification failed"),
            backgroundColor: Color.fromARGB(255, 77, 84, 229,),));
    }
  }
  Future ResendOtpMethod()async{
    try {
      var map = Map<dynamic, String>();
      final response = await Dio().post(
          'https://blacksquad.dev.fegno.com/api/v1/user/resent_otp/',
          // data: map,
          options: Options(headers: {
        'Accept': 'application/json'
      })
      );
        print(response.data);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data),
            backgroundColor: Color.fromARGB(255, 77, 84, 229,),));
    } catch (err){
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Couldn't Send Message. Please Contact Admin!"),
            backgroundColor: Color.fromARGB(255, 77, 84, 229,),));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height/6,
            ),
            Text('FEGSTORE',style: TextStyle(
                letterSpacing: 4,
                fontSize: 32,
                color: Color.fromARGB(255, 77,84,229,),
                fontWeight: FontWeight.w800
            ),),
            SizedBox(
              height: height/6,
            ),
            Text('Verify your number',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
            SizedBox(
              height: height/22,
            ),
            Text('Please enter 4 digit OTP sent to',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.grey),),
            SizedBox(
              height: height/80,
            ),
            Text('+919539109930',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.grey),),
            SizedBox(
              height: height/40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OTPTextField(
                  controller: _value1,
                ),
                OTPTextField(
                  controller: _value2,
                ),
                OTPTextField(
                  controller: _value3,
                ),
                OTPTextField(
                  controller: _value4,
                ),
              ],
            ),
            SizedBox(
              height: height/60,
            ),
            // BlocBuilder<TimerCubit,TimerState>(builder: (context,state){
            //   if(state is TimerInitial){
            //     return ElevatedButton(onPressed: (){
            //       BlocProvider.of<TimerCubit>(context).startTimer(30);
            //     }, child: Text("QQ"));
            //   } if(state is TimerProgress) {
            //     return Text("00:${state.elapsed.toString()}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.redAccent),);
            //   } else {
            //     return Container();
            //   }
            // }),
             Text('00:$_countdown',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.redAccent),),
            SizedBox(
              height: height/30,
            ),
            PrimaryButton(
                title: 'Verify',
              onPressed: (){
                  OtpVerificationMethod();
              },
            ),
            SizedBox(
              height: height/30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn't recieved the code? " ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.grey),),
                InkWell(
                  onTap: ()async{
                    print("RESEND!");
                   await ResendOtpMethod();
                  },
                    child: Text("Resend" ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.redAccent),)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OTPTextField extends StatelessWidget {
  final int fieldCount;
  final TextEditingController ? controller;
  final String hint;
  final Function ? onCompleted;
  final onChanged;

  OTPTextField({
    this.fieldCount = 4,
    required this.controller,
    this.hint = '',
    this.onCompleted,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: width/4.5,
      width: width/4.5,
      padding: EdgeInsets.all(8),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))
              )
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
          onChanged: onChanged
      ),
    );
  }
}