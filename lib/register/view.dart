import 'package:final_project/Character/views.dart';
import 'package:final_project/register/cubit.dart';
import 'package:final_project/register/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>RegisterCubit() ,
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.pink,
          title: Text("REGISTER" ,style:TextStyle(fontWeight: FontWeight.bold) ,),
        ),
        body:BlocListener <RegisterCubit,RegisterStates>(
          listener: (context,state){
            if(state is RegisterSuccessState){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CharacterView()));
            }else if (state is RegisterErrorState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Builder(
            builder: (context){
              final cubit=BlocProvider.of<RegisterCubit>(context);
              return Form(
                key: cubit.formKey,
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    TextFormField(
                      onSaved: (v) => cubit.Name=v,
                      decoration: InputDecoration(
                          hintText: "Name"
                      ),
                      validator: (v){
                        if(v==null ||v.isEmpty){
                          return "Name cannot be EMPTY !";
                        }
                        return null;

                      },
                    ),
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
                      onSaved: (v) => cubit.Phone=v,
                      decoration: InputDecoration(
                          hintText: "Phone"
                      ),
                      validator: (v){
                        if(v==null || v.isEmpty){
                          return "Phone cannot be EMPTY !";
                        }else if (!v.startsWith("+201")){
                          return "Phone must start with +201";
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
                     BlocBuilder<RegisterCubit,RegisterStates>(
                      builder: (BuildContext context, state) {
                        if (state is RegisterLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(color: Colors.black,),
                          );
                        };

                        return  ElevatedButton(
                            style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.pink) ),
                        onPressed:cubit.register,
                        child: Text("Register"));
                }


                     )],
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
