import 'package:flutter/material.dart';
import 'package:quiz_test/controler/user_controler.dart';


class InformationScreen extends StatefulWidget {



  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {


  @override
  void initState() {
    // TODO: implement initState

     // userControler.restorUser();
    // UserControler.LoadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF252c4a),
        elevation: 20,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Name',style: TextStyle(color: Colors.white),),
            Text('Level',style: TextStyle(color: Colors.white),),
            Text('Score',style: TextStyle(color: Colors.white),),
          ],
        ) ,
      ),
      backgroundColor: Color(0xFF252c4a),
      body: SizedBox(
        child:  ListView.separated(
            separatorBuilder: (context,index)=>Divider(thickness: 1,),
            itemCount:Cache.getUsers().length,
            itemBuilder: (context,index){
              // userControler.userListtwo[index].score=widget.score  ;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${Cache.getUsers()[index].name}',style: TextStyle(color: Colors.white),),
                    Text('${Cache.getUsers()[index].level}',style: TextStyle(color: Colors.white),),
                    Text('${Cache.getUsers()[index].score *10}',style: TextStyle(color: Colors.white),),
                  ],),
              );
            }
        ),
      )
    );
  }
}
