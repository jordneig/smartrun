

import 'package:flutter/material.dart';
import 'widgets/Employee.dart';
import 'widgets/Services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Items.dart';
void main() {
  runApp(Add());
}


class Add extends StatefulWidget {
  //
  Add() : super();
 
  final String title = 'Lista de Alunos';
 
  @override
  AddState createState() => AddState();
}
 
class AddState extends State<Add> {
   CalendarController _controller;
  List<Employee> _employees;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  TextEditingController _firstNameController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _lastNameController;
  TextEditingController _data_treino;
  Employee _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;
  TextEditingController textFieldController;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _data_treino = TextEditingController();
    textFieldController = TextEditingController();
    _getEmployees();
  }
 
  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }
 
  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
 
  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        // Table is created successfully.
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }
 
  // Now lets add an Employee
  _addEmployee() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Employee...');
    Services.addEmployee(_firstNameController.text, _lastNameController.text, _data_treino.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }
 
  _getEmployees() {
    _showProgress('Loading Employees...');
    Services.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${employees.length}");
    });
  }
 
  _updateEmployee(Employee employee) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    Services.updateEmployee(
            employee.id, _firstNameController.text, _lastNameController.text,_data_treino.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }
 
 
  // Method to clear TextField values
  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
    _data_treino.text = '';
  }
 
  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
           IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          )
       ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)),
          onPressed: (){
            _createTable();
            _addEmployee();
            return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retorna o texto que foi informado
                // usando o TextEditingController.
                content: Text(_lastNameController.text),
              );
            },
          );
          },
          child: Icon(Icons.add)) ,
      body: 
        SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Nome da turma',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                maxLength: 500,
                controller: _lastNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Treino',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _data_treino,
                decoration: InputDecoration.collapsed(
                  hintText: 'Data (....-..-..)',
                ),
              ),
            ),
                
          ],
          
          ),
         
          
        
                   
        )
            
            
        );
      
  }
}
