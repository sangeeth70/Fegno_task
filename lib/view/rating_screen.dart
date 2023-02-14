import 'package:dio/dio.dart';
import 'package:fegstore/view/fegstore_button.dart';
import 'package:fegstore/view/review_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../reviews.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int ? idx;

  double ? _rating = 3;
 final _reviewController = TextEditingController();

 Future AddReview()async{
   try{
     SharedPreferences sharedPreference = await SharedPreferences.getInstance();
     String? token = await sharedPreference.getString('token');
      var map = Map<dynamic, String>();
      final response = await Dio().post(
          'https://blacksquad.dev.fegno.com/api/v1/user/add-review/',
          data: map,
          options: Options(headers: {
            'Authorization': 'Token '+token.toString(),
            'Accept': 'application/json'
          }));
      if(response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.data['message'].toString()),
              backgroundColor: Color.fromARGB(255, 77, 84, 229,),));
        Reviews.items.add({'name': 'Fegno','rating':_rating,'review':_reviewController.text});
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewList()));
      }
      print(response.statusCode);
      print(Reviews.items);
   }catch(err){
     print({"ERROR => $err"});
   }
  }

  Future AddRating()async{
    try{
      var map = Map<dynamic, String>();
      final response = await Dio().post(
          'https://blacksquad.dev.fegno.com/api/v1/user/add-rating/',
          data: map,
          options: Options(headers: {
            'Authorization': 'Token aebfa15bcfbd010535971ee6c63f9a046d829967',
            'Accept': 'application/json'
          }));
      if(response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.data['message'].toString()),
              backgroundColor: Color.fromARGB(255, 77, 84, 229,),));
      }
      print(response.statusCode);
    }catch(err){
      print({"ERROR => $err"});
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
            Container(
              height: height / 1.1,
              width: width,
              child: Swiper(
                  layout: SwiperLayout.DEFAULT,
                  itemWidth:height/1.3,
                  itemHeight: width,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              SizedBox(
                                height: height / 6,
                              ),
                              Text(
                                'FEGSTORE',
                                style: TextStyle(
                                    letterSpacing: 4,
                                    fontSize: 32,
                                    color: Color.fromARGB(
                                      255,
                                      77,
                                      84,
                                      229,
                                    ),
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: height / 6,
                              ),
                              Text(
                                "Rate Your Experience",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Did you enjoy working with us?",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Please add your rating",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RatingBar.builder(
                                initialRating: _rating!,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.green,
                                ),
                                onRatingUpdate: (rating) async {
                                  await AddRating();
                                  setState(() {
                                    _rating = rating;
                                    print(_rating.runtimeType);
                                  });
                                },
                              ),
                              SizedBox(
                                height: height/8,
                              ),
                              PrimaryButton(
                                title: 'Next',
                                onPressed: () {
                                },
                              )
                              // RatingBar(),
                            ],
                          );
                        } else {
                          return Row(
                            children: [
                              // SizedBox(
                              //   width: 30,
                              // ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: height/10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Rating',
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: width/1.5,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height/40,
                                    width: width,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        _rating.toString() == 'null' ? '3.0' :  _rating.toString(),
                                        style: TextStyle(
                                            fontSize: 32,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,),

                                      ),
                                      RatingBar.builder(
                                        initialRating: _rating!,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.green,
                                        ),
                                        onRatingUpdate: (rating)async {
                                          await AddRating();
                                          setState(() {
                                            _rating = rating;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height/40,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Write your Review',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: width/2,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height/40,
                                  ),
                                  Container(
                                    child: TextField(
                                      maxLines: 6,
                                      controller: _reviewController,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(color: Colors.grey),
                                        hintText: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(12))
                                        ),
                                      ),
                                    ),
                                    width: width - 50,
                                  ),
                                  SizedBox(
                                    height: height/8,
                                  ),
                                  PrimaryButton(
                                    title: 'Save',
                                    onPressed: () {
                                      AddReview();
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> ReviewList()));
                                    },
                                  )
                                ],
                              ),
                            ],
                          );
                        }
                      },
                fade: 0.001,
                loop: false,
                pagination: SwiperControl(color: Colors.blue,disableColor: Colors.grey,size: 20),
                itemCount: 2,
            ),
              ),
          ],
        ),
      ),
    );
  }
}

// class RatingBar extends StatelessWidget {
//   const RatingBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Container(
//       height: width/6,
//       width: width,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           padding: EdgeInsets.only(left: width/14),
//           itemCount: 5,
//           itemBuilder: (BuildContext context, int index){
//         return Padding(
//           padding: EdgeInsets.only(right: width/25),
//           child: Column(
//             children: [
//               IconButton(onPressed: (){
//                 RatingStatus(index);
//               }, icon: Icon(,color: Colors.green,size: 40,)),
//               Text(Ratings.items[index]['title'].toString())
//             ],
//           ),
//         );
//       }
//       ),
//     );
//   }
//    RatingStatus(index) {
//     if(index == 1){
//
//     }
//   }
// }
//
// class Ratings {
//   static List<Map> items = [
//     {'title': 'Very Bad'},
//     {'title': 'Bad'},
//     {'title': 'Ok'},
//     {'title': 'Good'},
//     {'title': 'Excellent'},
//   ];
// }
