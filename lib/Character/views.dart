import 'package:dio/dio.dart';
import 'package:final_project/Character/controller.dart';
import 'package:final_project/register/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../login/view.dart';
import '../widgets/Character_card.dart';

class CharacterView extends StatefulWidget {
  const CharacterView({Key? key}) : super(key: key);

  @override
  State<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView> {

 bool isLoading=true;

 CharactersController charactersController=CharactersController();
  @override
    void initState() {
    charactersController.getAllCharacter().then((value) {
      isLoading=false;
      setState(() {});
    } );
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Characters", style: TextStyle(fontWeight: FontWeight.bold,),textAlign:TextAlign.center,),
        actions: [IconButton(onPressed: () async {
          final sp=await SharedPreferences.getInstance();
          sp.remove('token');
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginView()));
        },
            icon:Icon(Icons.login))],
      ),
      body: isLoading? Center(child: CircularProgressIndicator(strokeWidth: 4.5,color: Colors.pink,),) :GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1/1.5),
          itemCount: charactersController.characters.length,
          itemBuilder: (context , index) => CharacterCard(
           character:  charactersController.characters[index],
          )

      ),
    );
  }
}
