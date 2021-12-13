import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_test/controler/user_controler.dart';
import 'package:quiz_test/data/questions_example.dart';
import 'package:quiz_test/model/user_model.dart';
import 'package:quiz_test/screens/information_screen.dart';
import 'package:quiz_test/screens/main_menu.dart';
import 'package:quiz_test/screens/result_screen.dart';
import 'package:quiz_test/ui/shared/color.dart';
import 'package:quiz_test/widgets/quizz_widget.dart';
import 'package:quiz_test/model/question_model.dart';

class QuizzScreen extends StatefulWidget {
  final String name;
  final String level;
  const QuizzScreen({Key? key, required this.name, required this.level}) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  int question_pos = 0;
  int score = 0;
  int minut=1 ;
  int seconed=0 ;
  Timer? timer;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next Question";
  bool answered = false;
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    getListQusetion(widget.level);
   // checkTimer();
    super.initState();
    _controller = PageController(initialPage: 0);
  }
   startTimer(){
  //  counter=30;
    if(timer !=null){
      timer!.cancel();
    }
    if(seconed>60){
      minut=(seconed/60).floor();
      seconed-=(minut*60);
    }
    timer=Timer.periodic(
        Duration(seconds: 1),
            (timer) {
             setState(() {
               if(seconed>0){
                 seconed --;
               }else if(minut>0){
                 seconed=59;
                 minut--;
               }else{

                 timer.cancel();
                 btnPressed=true;
                 // showDialog(
                 //     context: (context),
                 //     builder: (context){
                 //       return AlertDialog(
                 //         title: Text('done'),
                 //       );
                 //     }
                 // );
               }

             });
            });

   }
   void stopTime(){
    timer!.cancel();
    seconed=0;
    minut=1;
   }
   Future<bool> onBackPresed()async{
     bool check =false ;
     showDialog
       (
         context: context,
         builder: (context){
           return AlertDialog(
             title: Text('Do you want finish quiz ?'),
             actions: [
               FlatButton(
                   onPressed: (){
                     Navigator.of(context).pop(check);
                   },
                   child: Text('No')),
               FlatButton(
                   onPressed: (){
                     listQuestion.clear();
                     Navigator.of(context).pushReplacement(
                         MaterialPageRoute(builder: (context)=>MainMenu()));;
                   },
                   child: Text('Yes')),
             ],
           );
         }
     );
     return check;
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.pripmaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Score  ${score *10} / ${listQuestion.length *10}'),
            IconButton(onPressed: (){
              // UserControler.updatUser(score);
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> InformationScreen()));
            }, icon: Icon(Icons.info_outlined))
          ],
        ),
      ),
      backgroundColor: AppColor.pripmaryColor,
      body: WillPopScope(

        onWillPop:onBackPresed,
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: PageView.builder(
              controller: _controller!,
              onPageChanged: (page) {
                if (page == listQuestion.length - 1) {
                  setState(() {
                    btnText = "See Results";
                  });
                }
                setState(() {
                  answered = false;
                });
              },
              physics: new NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,

                      child: Center(
                        child: Text('$minut : $seconed', style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Question ${index + 1}/${listQuestion.length}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 150.0,
                      child: Text(
                        "${listQuestion[index].question}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                    for (int i = 0; i < listQuestion[index].answers!.length; i++)
                      Container(
                        width: double.infinity,
                        height: 50.0,
                        margin: EdgeInsets.only(
                            bottom: 20.0, left: 12.0, right: 12.0),
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          fillColor: btnPressed
                              ? listQuestion[index].answers!.values.toList()[i]
                                  ? Colors.green
                                  : Colors.red
                              : AppColor.secondaryColor,
                          onPressed: !answered
                              ? () {
                                  if (listQuestion[index]
                                      .answers!
                                      .values
                                      .toList()[i]) {
                                    score++;
                                    print("yes");
                                  } else {
                                    print("no");
                                  }
                                  setState(() {
                                    btnPressed = true;
                                    answered = true;
                                    timer!.cancel();
                                  });
                                }
                              : null,
                          child: Text(listQuestion[index].answers!.keys.toList()[i],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              )),
                        ),
                      ),
                    SizedBox(
                      height: 40.0,
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        if (_controller!.page?.toInt() == listQuestion.length - 1) {
                          User user = User(name: widget.name, level: widget.level, score: score);
                          Cache.addUser(user);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(score)));
                        } else {
                          _controller!.nextPage(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInExpo);
                         stopTime();

                          setState(() {
                           startTimer();
                            btnPressed = false;
                          });
                        }
                      },
                      shape: StadiumBorder(),
                      fillColor: Colors.blue,
                      padding: EdgeInsets.all(18.0),
                      elevation: 0.0,
                      child: Text(
                        btnText,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                );
              },
              itemCount: listQuestion.length,
            )),
      ),
    );
  }
}
