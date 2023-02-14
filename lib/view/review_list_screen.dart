import 'package:flutter/material.dart';

import '../reviews.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({Key? key}) : super(key: key);

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Replies',
          style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: ListView.builder(
          itemCount: Reviews.items.length,
            itemBuilder: (BuildContext context,int index){
          return ReviewTile(
            username: Reviews.items[index]['name'].toString(),
            rate:Reviews.items[index]['rating'].toString(),
            review: Reviews.items[index]['review'].toString(),
          );
        }),
      )
    );
  }
}

class ReviewTile extends StatelessWidget {
  String username;
  String rate;
  String review;
   ReviewTile({Key? key,required this.username,required this.rate,required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(bottom: height/40),
      margin: EdgeInsets.only(left: 6,right: 6,top: 20),
      // height: height/4,
      width: width -50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.shade300
      ),
      child: Column(
        children: [
          SizedBox(
            height: height/50,
          ),
          Row(
            children: [
              SizedBox(width: width/30,),
              Icon(Icons.account_circle,size: 40,color: Colors.black54,),
              SizedBox(width: width/30,),
              Container(
                width: width/2.1,
                child: Text(
                  username.toString()!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: width/40,),
              Container(
                height: 32,
                width: 64,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(rate!.toString()),
                    Icon(Icons.star),
                  ],
                ),
              ),
              IconButton(onPressed: (){
                print("Options!");
              }, icon: Icon(Icons.more_vert))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(review,style: TextStyle(
              fontSize: 16,
              color: Colors.black54
            ),),
          )
        ],
      ),
    );
  }
}

