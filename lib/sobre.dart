import 'package:flutter/material.dart';
import 'package:smartrun/menu.dart';

class sobrePage extends StatefulWidget {
  @override
  _sobrePageState createState() => _sobrePageState();
}

class _sobrePageState extends State<sobrePage> {
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Sobre nós"),
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: (){
            Navigator.push(context, new MaterialPageRoute(
                 builder: (BuildContext context) => new MenuDashboards()) 
            );
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          quadro(context),
          lado(context)
        ],
      ),
    );
  }
  

  Widget quadro(context){
    return Padding(
      padding: const EdgeInsets.all(16),
       child: Material(
         color: backgroundColor,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('card 1'),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('BUY TICKETS'),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton(
                    child: const Text('LISTEN'),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget lado(context){
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,top: 174,right: 16.0,bottom: 16.0),
       child: Material(
         color: backgroundColor,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('card 2'),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('BUY TICKETS'),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton(
                    child: const Text('LISTEN'),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}