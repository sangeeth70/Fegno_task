import 'package:fegstore/counter_bloc';
import 'package:fegstore/view/signin.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
    });
  }
  // final _bloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        color: Color.fromARGB(255, 77,84,229,),
        child: Column(
          children: [
            SizedBox(
              height: height/2.2,
            ),
            Text('FEGSTORE',style: TextStyle(
              letterSpacing: 4,
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.w800
            ),),
            SizedBox(
              height: height/4,
            ),
            Container(
              height: MediaQuery.of(context).size.height/6,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/fegno.png')
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
