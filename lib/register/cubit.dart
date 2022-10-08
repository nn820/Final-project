import 'package:dio/dio.dart';
import 'package:final_project/register/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() :super(RegisterInitState());


  String? Name;
  String? Email;
  String? Phone;
  String? Password;


   final formKey =GlobalKey<FormState>();


  Future <void> register() async {
    if(!formKey.currentState!.validate()){
      return;
    }
    emit(RegisterLoadingState());
    formKey.currentState! .save();
    try{

      final response= await Dio().post('https://student.valuxapps.com/api/register'
          ,
          data: {
            'name': Name,
            'email' :Email,
            'password':Password,
            'phone':Phone


          });

      if(response.data['status']){
        SharedPreferences sp=await SharedPreferences.getInstance();
        sp.setString('token', response.data['data']['token']);
        print(sp.getString('token'));
        emit(RegisterSuccessState());
      }else {
        emit(RegisterErrorState(
          message: response.data['message'],
        ));
      }
    }catch(e){
      emit(RegisterErrorState(
        message: e.toString(),
      ));
    }


    
  }



}


