import 'package:dio/dio.dart';
import 'package:final_project/login/states.dart';
import 'package:final_project/register/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() :super(LoginInitState());



  String? Email;

  String? Password;


  final formKey =GlobalKey<FormState>();


  Future <void> login() async {
    if(!formKey.currentState!.validate()){
      return;
    }
    emit(LoginLoadingState());
    formKey.currentState! .save();
    try{

      final response= await Dio().post('https://student.valuxapps.com/api/login'
          ,
          data: {

            'email' :Email,
            'password':Password,



          });

      if(response.data['status']){
        SharedPreferences sp=await SharedPreferences.getInstance();
        sp.setString('token', response.data['data']['token']);
        print(sp.getString('token'));
        emit(LoginSuccessState());
      }else {
        emit(LoginErrorState(
          message: response.data['message'],
        ));
      }
    }catch(e){
      emit(LoginErrorState(
        message: e.toString(),
      ));
    }



  }



}


