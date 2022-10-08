import 'package:final_project/Character/views.dart';
import 'package:final_project/login/states.dart';
import 'package:final_project/register/cubit.dart';
import 'package:final_project/register/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../register/view.dart';
import 'cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>LoginCubit() ,
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.pink,
          title: Text("LOGIN" ,style:TextStyle(fontWeight: FontWeight.bold) ,),
        ),
        body:BlocListener <LoginCubit,LoginStates>(
          listener: (context,state){
            if(state is LoginSuccessState){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CharacterView()));
            }else if (state is LoginErrorState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Builder(
            builder: (context){
              final cubit=BlocProvider.of<LoginCubit>(context);
              return Form(
                key: cubit.formKey,
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [

                    SizedBox(height: 10,),
                    TextFormField(
                      onSaved: (v) => cubit.Email=v,
                      decoration: InputDecoration(
                          hintText: "Email"
                      ),
                      validator: (v){
                        if(v==null ||v.isEmpty){
                          return "Email cannot be EMPTY !";
                        }else if (!v.contains("@")){
                          return "Email must contain @";
                        }
                        return null;

                      },
                    ),


                    SizedBox(height: 10,),
                    TextFormField(
                      onSaved: (v) => cubit.Password=v,
                      decoration: InputDecoration(
                          hintText: "Password"
                      ),
                      validator: (v){
                        if(v==null ||v.isEmpty){
                          return "Password cannot be EMPTY !";
                        }else if (v.length<6){
                          return "Password must be at least 6 characters";
                        }
                        return null;

                      },
                    ),
                    SizedBox(height: 10,),
                    BlocBuilder<LoginCubit,LoginStates>(
                        builder: (BuildContext context, state) {
                          if (state is LoginLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(color: Colors.black,),
                            );
                          };

                          return  ElevatedButton(
                              style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.pink) ),
                              onPressed:cubit.login,
                              child: Text("Login"));
                        }


                    ),
                    SizedBox(height: 5,),
              InkWell(
              onTap:() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  RegisterView()
              ));
              },
              child: ElevatedButton(
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.pink) ),
              onPressed:(){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  RegisterView()));},
              child: Text("Register")),)


                  ],
                ),
              );
            },

          ),
        )
        ,
      ),
    );
  }
}
