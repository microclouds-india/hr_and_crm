import 'package:flutter/material.dart';

class RegisterScreenUi extends StatelessWidget {
  const RegisterScreenUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pink.shade900,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
       ),
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text('10%',style: TextStyle(
            
                  color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold
                ),),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Complete',style: TextStyle(
                    color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20
                  ),),
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Personal Details',style: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,fontWeight: FontWeight.bold
                ),),
              ],
            ),
            SizedBox(height: 10,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: Container(
            //         height: 5,
                    
            //         decoration: BoxDecoration(
            //           color: Colors.pink,
            //           borderRadius: BorderRadius.all(Radius.circular(10))
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: Container(
            //         height: 5,
                    
            //         decoration: BoxDecoration(
            //           color: Colors.pink,
            //           borderRadius: BorderRadius.all(Radius.circular(10))
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: Container(
            //         height: 5,
                   
            //         decoration: BoxDecoration(
            //           color: Colors.pink,
            //           borderRadius: BorderRadius.all(Radius.circular(10))
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: Container(
            //         height: 5,
                    
            //         decoration: BoxDecoration(
            //           color: Colors.pink,
            //           borderRadius: BorderRadius.all(Radius.circular(10))
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            
          ],
        ),
      ),
    );
  }
}