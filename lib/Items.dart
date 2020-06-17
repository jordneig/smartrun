

import 'package:HelloWorld/widgets/Employee.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(Items());
}



class Items extends StatelessWidget {
  final Employee employee;

  const Items({Key key, this.employee}) : super(key: key);
  

  // controller for the First Name TextField we are going to create.
 

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(
          title: Text(employee.firstName),
        ),
      body: 
        SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Card(
              child: Container(
                child: Column(
                  children: <Widget>[  
                      ListTile(
                        title: Text('Descrição'),
                        subtitle: Text(employee.lastName),
                      ),
                  ],
                ),
              ),
            ),
            
                  
          ],
          
          ),
         
          
        
                   
        )
            
            
        );
      
  }
}