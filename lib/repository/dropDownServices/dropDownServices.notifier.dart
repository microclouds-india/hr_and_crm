

import 'package:flutter/material.dart';

class DropDownServiceNotifier with ChangeNotifier{
   var addressDropDownList = ["micro", "Address 2", "Address 3","Address 4"];
   var selectedAddress = "micro";

   setAddressValue(value){
     selectedAddress = value;
     notifyListeners();
   }
}