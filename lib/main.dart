import 'package:datos_03/helpers/user_preference.dart';
import 'package:flutter/material.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    UserPreference userPreference =  UserPreference();
    await userPreference.initPrefers();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final ageController = TextEditingController();

  List<String> myMusic = [];

  UserPreference userPreference =  UserPreference();

  @override

  void initState(){
    UserPreference userPreference =  UserPreference();

    nameController.text = userPreference.name;
    surnameController.text = userPreference.surname;
    ageController.text= "${userPreference.age}";

    myMusic = userPreference.favoriteMusic;
    

    super.initState();
  }
  

  @override
  Widget build(BuildContext context)   {

      return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: Text("App para guaradar datos 03"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center ,
          children: [
          TextField(
            controller: nameController,
            onChanged: (String value){
              userPreference.name = value;
            },
            decoration: InputDecoration(contentPadding: EdgeInsets.all(4),
            hintText: "Nombre"),
          ),
           TextField(
            controller: surnameController,
            onChanged: (String value){
             userPreference.surname = value;
              
            },
            decoration: InputDecoration(contentPadding: EdgeInsets.all(4),
            hintText: "Apellido"),
          ),
           TextField(
            controller: ageController,
            onChanged: (String value){
              try{
               userPreference.age = int.parse(value);

              }catch (e){}
              
              },
            decoration: InputDecoration(contentPadding: EdgeInsets.all(4),
            hintText: "Edad"),
          ),
          DropdownButton<bool>(
            value: userPreference.married,
            isExpanded: true,
            items: [
              DropdownMenuItem<bool>(
                child: Text('Casado'), value: true,),
              DropdownMenuItem<bool>(
                child: Text('Soltero'), 
                value: false,)
            ],
            onChanged: (bool? value){
              setState(() {
                 userPreference.married = value!;
              });
             
            }),

           musicCheckbox(),
            Spacer(),
            FlatButton(
              textColor: Colors.white,
              color: Colors.redAccent,
             // onPressed: userPreference.clean, 
             onPressed:(){
               setState(() {
                 nameController.text = "";
                 surnameController.text = "";
                 ageController.text= "0";
                 myMusic = [];
                 userPreference.clean();
               });
             },
              child: Text("Limpiar"))
        ],
        ),
        padding: EdgeInsets.all(8),
      ),
      ),
      
    );
  }

  Widget musicCheckbox(){

    List<String> music = ['Electronic', 'Indie', 'Rock', 'Pop'];

    return Column(
      children: music
      .map(
        (m) => CheckboxListTile(
          title: Text(m),
          secondary: Icon(Icons.music_note, color: Colors.blue,),
          activeColor: Colors.red ,
          checkColor: Colors.white,
          value: myMusic.indexOf(m) >= 0, 
          onChanged: (_){

          if(myMusic.indexOf(m) < 0){
            myMusic.add(m);
          }else{
            myMusic.remove(m);
          }
          
         userPreference.favoriteMusic = myMusic;
         setState((){});

        }),)
    .toList(),
    );
    
  }
}
