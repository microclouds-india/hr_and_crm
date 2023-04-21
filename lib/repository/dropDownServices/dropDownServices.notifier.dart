

import 'package:flutter/material.dart';

class DropDownServiceNotifier with ChangeNotifier{
   var addressDropDownList = ["micro", "Address 2", "Address 3","Address 4"];
   var registrationJobrole = ["Hr", "Manager", "Employee"];
   var selectedAddress = "micro";
   var selectedregistrationJobrole = "Hr";

   setAddressValue(value){
     selectedAddress = value;
     notifyListeners();
   }

   setRegistrationJobrole(value){
     selectedregistrationJobrole = value;
     notifyListeners();
   }
}