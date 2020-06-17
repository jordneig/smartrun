


import 'package:flutter/material.dart';
import 'widgets/Employee.dart';
import 'widgets/Services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Items.dart';
import 'Add.dart';
import 'dart:developer';
void main() {
  runApp(DataTableDemo());
}


class DataTableDemo extends StatefulWidget {
  //
  DataTableDemo() : super();
 
  final String title = 'Lista de Alunos';
 
  @override
  DataTableDemoState createState() => DataTableDemoState();
}
 
class DataTableDemoState extends State<DataTableDemo> {
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
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty ||  _data_treino.text.isEmpty ) {
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
 
  _deleteEmployee(Employee employee) {
    _showProgress('Deleting Employee...');
    Services.deleteEmployee(employee.id).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh after delete...
      }
    });
  }
 
  // Method to clear TextField values
  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
    _data_treino.text = '';
  }
 
  _showValues(Employee employee) {
    _firstNameController.text = employee.firstName;
    _lastNameController.text = employee.lastName;
    _data_treino.text = employee.datatreino;
  }
 
  _sendDataToItems(BuildContext context){
    String textToSend = textFieldController.text;
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => Items(),),
      );
  }
  // Let's create a DataTable and show the employee list in it.
 
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => Add())
            );
          },
          child: Icon(Icons.add)) ,
      body: 
        SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          //  TableCalendar(
           //   calendarStyle: CalendarStyle(
           //     todayColor: Colors.amber
           //   ),
           //   headerStyle: HeaderStyle(
           //     centerHeaderTitle: true
           //   ),
           //   calendarController: _controller,),
            DataTable(
              sortColumnIndex: 1,
              sortAscending: true,
            columns: [
              DataColumn(
                label: Text(''),
              ),
              DataColumn(
                label: Text(
                  'Turmas',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu'),),
              ),
              // Uma coluna pra mostrar o button Delete
              DataColumn(
                label: Text(''),
              )
            ],
            rows: _employees
              .map(
                (employee) => DataRow(cells: [
                  DataCell(
                    Text(employee.datatreino,
                    style: TextStyle(
                    fontFamily: 'Ubuntu'),),
                    
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                       
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      log(_selectedEmployee.firstName);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Items(employee: _selectedEmployee,)));
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.firstName.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Ubuntu'),
                    ),
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => Items(employee: _selectedEmployee,)));
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteEmployee(employee);
                    },
                  ))
                ]),
              )
              .toList(),), 
            _isUpdating
                ? Row(
                    children: <Widget>[
                      OutlineButton(
                        child: Text('UPDATE'),
                        onPressed: () {
                          _updateEmployee(_selectedEmployee);
                        },
                      ),
                      OutlineButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          setState(() {
                            _isUpdating = false;
                          });
                          _clearValues();
                        },
                      ),
                    ],
                  )
                : Container(), 
                   
          ],
          ),          
        )  
        );
  }
}
class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
              return  new Card(
                    child: new Column(
                      children: <Widget>[
                        new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                        new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Row(
                            children: <Widget>[
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Icon(Icons.thumb_up),
                             ),
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Text('Like',style: new TextStyle(fontSize: 18.0),),
                             ),
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Icon(Icons.comment),
                             ),
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Text('Comments',style: new TextStyle(fontSize: 18.0)),
                             )

                            ],
                          )
                        )
                      ],
                    ),
                  );}}