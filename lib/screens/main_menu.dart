import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_test/const/constants.dart';
import 'package:quiz_test/controler/user_controler.dart';
import 'package:quiz_test/model/user_model.dart';
import 'package:quiz_test/screens/quizz_screen.dart';
import 'package:quiz_test/ui/shared/color.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  TextEditingController textControler=TextEditingController();

  dispose(){
    textControler.dispose();
    super.dispose();
  }

  String dropdownValue = 'Chose Level';
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pripmaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 48.0,
          horizontal: 12.0,
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 150,),
                const Center(
                  child: Text(
                    "Quizz App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                TextFormField(

                  validator: (e){
                    if(e!.isEmpty) return 'enter name';
                    return null;
                  },
                  style: TextStyle(color:kGrayColor),
                  controller: textControler,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1C2341),
                    hintText: "Full Name",
                    hintStyle: TextStyle(color: kGrayColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(

                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFF1C2341),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down,color: kGrayColor,),
                      iconSize: 42,
                      underline: SizedBox(),
                      onChanged: (String? v){
                        setState(() {
                          dropdownValue=v!;
                        });
                      },

                      items: <String>['Chose Level','Easy','Middel','Hard']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(color:kGrayColor),),
                        );
                      }).toList(),
                    )

                ),
                SizedBox(height: 100,),
                Center(
                  child: RawMaterialButton(
                    onPressed: () {
                      //Navigating the the Quizz Screen
                      if(formKey.currentState!.validate()){
                        var user=User(name: textControler.text, level: dropdownValue, score: 0);
                        // UserControler.addUser(user);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizzScreen(
                                level: dropdownValue,
                                name: textControler.text,
                              ),
                            ));
                      }

                    },
                    shape: const StadiumBorder(),
                    fillColor: AppColor.secondaryColor,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                      child: Text(
                        "Start the Quizz",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
