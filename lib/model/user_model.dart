class User{
 late String name;
 late String level;
 late int score;
  User({ required this.name,required this.level,required this.score});

  User.fromJson(Map<dynamic,dynamic> json){
    name=json['name'] ;
    level=json['level'] ;
    score=json['score'] ;

  }


  Map<dynamic,dynamic> toJson(){
    var data=Map<String,dynamic>();
    data['name']=this.name;
    data['level']=this.level;
    data['score']=this.score;

    return data;
  }
}