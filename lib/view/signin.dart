import 'package:fegstore/view/fegstore_button.dart';
import 'package:fegstore/view/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _contact = TextEditingController();
  Future<void> SignIn()async{
    var map = Map<dynamic,String>();
    map['mobile'] = _contact.text;
    map['name'] = _contact.text;
    map['app_sign'] = _contact.text;
    final response = await Dio().post('https://blacksquad.dev.fegno.com/api/v1/user/enter_mobile/',
        data: map);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    if(response.data['otp'] != null){
      print(response.data);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerification(number:_contact.text.toString())));

    }

  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height/4,
                ),
                Text('Welcome To',style: TextStyle(fontSize: 32,fontWeight: FontWeight.w600),),
                SizedBox(
                  height: height/16,
                ),
                Text('FEGSTORE',style: TextStyle(
                    letterSpacing: 4,
                    fontSize: 32,
                    color: Color.fromARGB(255, 77,84,229,),
                    fontWeight: FontWeight.w800
                ),),
                SizedBox(
                  height: height/12,
                ),
                Container(
                  width: width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Divider(
                          thickness: 2,
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Text('Log In or Sign Up',style: TextStyle(fontSize: 16),)),

                    ],
                  ),
                ),
                SizedBox(
                  height: height/30,
                ),
                Container(
                  height: height/16,
                  width: width - 30,
                  child: TextField(
                    controller: _contact,
                    decoration: InputDecoration(
                      hintText: 'Please enter your phone number or Email',
                      hintStyle: TextStyle(color: Colors.grey,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),

                  ),
                ),
                SizedBox(
                  height: height/30,
                ),
                PrimaryButton(title: 'Continue',onPressed: ()=> SignIn(),
                ),
                SizedBox(
                  height: height/25,
                ),
                Text('By clicking Continue, you agree to',style: TextStyle(fontSize: 14,color: Colors.grey),),
                SizedBox(
                  height: height/80,
                ),
                Row(
                  children: [
                    Text('Privacy Policy',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w600),),
                    Text(' and ',style: TextStyle(fontSize: 14,color: Colors.grey),),
                    Text('Terms & Conditions',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w600),),
                  ],
                ),
                SizedBox(
                  height: height/25,
                ),
                InkWell(
                  onTap: (){
                    print("SKIP!");
                  },
                  child: Container(
                    height: height/20,
                    width: width/1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Skip",style: TextStyle(color: Colors.grey,fontSize: 16),),
                        SizedBox(
                          width: width/40,
                        ),
                        Icon(Icons.arrow_circle_right)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldWithBorder extends StatefulWidget {
  bool? showBorder;
  TextFieldWithBorder({required this.showBorder});
  @override
  _TextFieldWithBorderState createState() => _TextFieldWithBorderState();
}

class _TextFieldWithBorderState extends State<TextFieldWithBorder> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      child: TextField(
        onTap: (){
          setState(() {
            widget.showBorder = true;
          });
        },
        enabled: widget.showBorder! ? true :false,
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
      ),
    );
  }
}





