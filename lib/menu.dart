import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smartrun/perfil.dart';
import 'package:smartrun/sobre.dart';
import 'package:table_calendar/table_calendar.dart';

final Color backgroundColor = Color(0xFF1565C0);

class MenuDashboards extends StatefulWidget{
  @override
  _MenuDashboardsState createState() => _MenuDashboardsState();
}

class _MenuDashboardsState extends State<MenuDashboards> {
  CalendarController _controller;

  @override
  void initState(){
    super.initState();
    _controller = CalendarController();
  }

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          menu(context),
          controle(context),
        ],
      ),
    );
  }

  Widget tela(context){
    return Padding(
      padding: const EdgeInsets.all(0.0),
        child: Container(
          child: PageView(
            controller: PageController(viewportFraction: 0.8),
            scrollDirection: Axis.vertical, //rolagem para os lados
            pageSnapping: true,
            children: <Widget>[
              calendario(context),
              cadernos(context),
            ],
          ),

        ),
      );
  }

  Widget calendario(context){
    return Padding(
      padding: const EdgeInsets.only(left: 12.0,top: 0.0,right: 12.0,bottom: 12.0),
      child: Column(
        children: <Widget>[
          TableCalendar(calendarController: _controller,),
        ]
      ),
      );
  }

  Widget menu(context) {
    return Padding(
      padding: const EdgeInsets.all(0.0), // margem de do quadro o corpo da tela
      child: Material(
        color: backgroundColor,
              child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround ,
                crossAxisAlignment:  CrossAxisAlignment.start,
                children: <Widget>[
                  new ListTile(
                    title: new Text("Perfil",style: TextStyle(color: Colors.white, fontSize: 18)),
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context) => new Perfilpage()) 
                      );
                    },
                  ),
                  new Divider(
                    color: Colors.black,
                    height: 3.0,
                  ),
                  new ListTile(
                    title: new Text("Meus Pagamentos",style: TextStyle(color: Colors.white, fontSize: 18)),
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context) => new Perfilpage()) 
                      );
                    },
                  ),
                  new Divider(
                    color: Colors.black,
                    height: 3.0,
                  ),
                  new ListTile(
                    title: new Text("Alunos",style: TextStyle(color: Colors.white, fontSize: 18)),
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context) => new Perfilpage()) 
                      );
                    },
                  ),
                  new Divider(
                    color: Colors.black,
                    height: 3.0,
                  ),
                  new ListTile(
                    title: new Text("Sobre Nós",style: TextStyle(color: Colors.white, fontSize: 18)),
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context) => new sobrePage()) 
                      );
                    },
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget controle(context){
    return AnimatedPositioned(
        duration: duration,
        top: isCollapsed ? 0: 0.2 * screenHeight,
        bottom: isCollapsed ? 0: 0.2 * screenWidth,
        left: isCollapsed ? 0: 0.6 * screenWidth,
        right:isCollapsed ? 0: -0.4 * screenWidth,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          elevation: 8,
          color: backgroundColor,
          child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top:48),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    InkWell(child: Icon(Icons.menu, color: Colors.white), onTap: (){
                      setState(() {
                        isCollapsed = !isCollapsed;
                      });
                    }),
                    Text("Agenda", style: TextStyle(fontSize: 24, color: Colors.white)),
                    Icon(Icons.settings, color: Colors.white), 
                    
                  ]),
                SizedBox(height: 50,),
                tela(context),
                
              ],
            ),
          ),
        ) 
      ),
    );
  }

  Widget cadernos(context){
    return Padding(
      padding:const EdgeInsets.only(left: 16.0,top:20.0,right: 16.0,bottom: 0.0),
                  child: Container(
                    height: 100,
                      child: PageView(
                      controller: PageController(viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal, //rolagem para os lados
                      pageSnapping: true,
                      children: <Widget>[
                        Card(
                           margin: const EdgeInsets.symmetric(horizontal: 8),
                           color: Colors.red[100],
                           //width: 100,
                        ),
                        Card(
                           margin: const EdgeInsets.symmetric(horizontal: 8),
                           color: Colors.blue[100],
                           //width: 100,
                        ),
                        Card(
                           margin: const EdgeInsets.symmetric(horizontal: 8),
                           color: Colors.green[100],
                           //width: 100,
                        ),
                      ],
                    ),
                  ),
            
    );
  }
}
 
