import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proyecto_01/screens/Catalogo.dart';
import 'package:proyecto_01/screens/Login.dart';

void main (){
  runApp(Proyecto());
}

class Proyecto extends StatefulWidget {
  const Proyecto({super.key});

  @override
  State<Proyecto> createState() => _ProyectoState();
}

class _ProyectoState extends State<Proyecto> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Proyecto",
      home:Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indice = 0;
  @override
  Widget build(BuildContext context) {
   List <Widget> screens = [Cuerpo(context),const Login(),const Catalogo()];
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Monkey Pelis"),
        backgroundColor: Colors.white70,
      ),
      body: screens[indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,
        onTap:(value) {
          setState(() {
            indice = value;
          });
        },
        items: const[
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label:"Home"),
         BottomNavigationBarItem(icon: Icon(Icons.contact_mail_outlined), label:"Registro"),
        BottomNavigationBarItem(icon: Icon(Icons.computer_rounded), label:"Catalogo"),
       
      ]),


    );
  }
}

Widget Cuerpo( context){
  return Container (
    decoration: BoxDecoration(
      image:DecorationImage(image: AssetImage('assets/image/1bkc.jpg'),
      fit:BoxFit.cover
    ),
  ),

  child: Column(
    children: [
      Text("Login", style: TextStyle(fontSize: 30, color: Color.fromARGB(237, 250, 0, 0) ),),
      NickName(),
      Password(),
    Boton1(context)

    ],

  ),
  );
}

Widget NickName(){
  return(
    Container(
      padding: EdgeInsets.all(10),
      child: TextField(style: TextStyle(backgroundColor: Color.fromARGB(255, 214, 158, 233)),
      decoration: InputDecoration(
        hintText: "Ingresar NickName",
        fillColor: Color.fromARGB(255, 30, 48, 85),
      ),
    )
  )
  );
}

Widget Password(){
  return(
    Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: true,
        style: TextStyle(backgroundColor: Color.fromARGB(255, 214, 158, 233)),
      decoration: InputDecoration(
        hintText: "Ingresar Pasword",
        fillColor: Color(0xffb3a2b9),
        filled: true
      ),
      keyboardType: TextInputType.multiline,
    ),
  )
  );
}

Widget Boton1( context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Catalogo()),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      textStyle: const TextStyle(fontSize: 16),
    ),
    child: const Text("Login"),
  );
}