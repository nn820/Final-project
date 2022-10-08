import 'package:final_project/Character/views.dart';
import 'package:final_project/register/view.dart';
import 'package:final_project/widgets/Character_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sp=await SharedPreferences.getInstance();
  final isLoggedIn=sp.getString('token')!= null;
  runApp( MyApp( home: isLoggedIn ? CharacterView():RegisterView() ,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.home}) : super(key: key);

  final Widget home;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:LoginView(),
    );
  }



}


  // This widget is the root of your application.
