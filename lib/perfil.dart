import 'package:flutter/material.dart';
import 'package:smartrun/menu.dart';
class Perfilpage extends StatefulWidget {
  @override
  _PerfilpageState createState() => _PerfilpageState();
}

class _PerfilpageState extends State<Perfilpage> {
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Perfil"),
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
          corpo(context),
          quadro1()
        ],
      ),
    );
  }
  
  Widget corpo(context){
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/4,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16)
            ),
          ),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: circleImage()
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Nome: Jessica Mayumi',style: TextStyle(color: Colors.white),textAlign: TextAlign.left,),
                        Text('Nascimento: 12/12/2012',style: TextStyle(color: Colors.white),textAlign: TextAlign.left,),
                        Text('Email: jessmayumi@hotmail.com',style: TextStyle(color: Colors.white),textAlign: TextAlign.left,),
                        Text('CPF: 000.938.298-23',style: TextStyle(color: Colors.white),textAlign: TextAlign.left,),
                        Text('Telefone: (91) 9283-7472',style: TextStyle(color: Colors.white),textAlign: TextAlign.left,)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
 
circleImage() {
    return Center(
      child : new Container(
      width: 90.0,
      height: 90.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
          fit: BoxFit.fill,
          image: new AssetImage('./assets/perfil.jpg')
            )
        ),
     ),
   );
  }

  quadro1(){
    return Padding(
      padding: const EdgeInsets.only(left: 12.0,top: 178,right: 12.0,bottom: 12.0),
       child: Material(
         color: backgroundColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16))
            ),
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
      ),
    );
  }
  
}