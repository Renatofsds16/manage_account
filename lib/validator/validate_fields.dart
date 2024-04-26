import 'package:flutter/material.dart';

class ValidatorFields{
  TextEditingController _controller = TextEditingController();




  ValidatorFields(this._controller);
  TextEditingController get controller => _controller;

  set controller(TextEditingController value) {
    _controller = value;
  }

  bool validateField(){
    if(controller.text.isNotEmpty){
      if(controller.text.length >= 
          6){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }
  //contains('@gmail.com')
  bool validatorFieldEmail(){
    if(controller.text.isNotEmpty){
      if(controller.text.endsWith('@gmail.com')){
        return true;
      }else{
        return false;
      }

    }else{
      return false;
    }

  }

}