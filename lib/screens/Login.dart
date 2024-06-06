import 'package:flutter/material.dart';
import 'package:proyecto_01/main.dart';


void main(){
  runApp( Login());

}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
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
  @override
  Widget build(context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Text("Login"),
        backgroundColor:Colors.white70,
      ),*/
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(context){
  return Container(
        decoration: BoxDecoration(
      image:DecorationImage(image: AssetImage('assets/image/1bkc.jpg'),
      fit:BoxFit.cover
    ),
  ),

  child: Column(
    children: <Widget> [
      Text("Registro", style: TextStyle(fontSize: 30, color: Color.fromARGB(237, 250, 0, 0) ),),
      NickName(),
      Correo(),
      Password(),
      Boton1(context)


    ],

  ),
  );
}
  

Widget Correo(){
  return(
    Container(
      padding: EdgeInsets.all(10),
      child: TextField(style: TextStyle(backgroundColor: Color.fromARGB(255, 214, 158, 233)),
      decoration: InputDecoration(
        hintText: "Ingresar Correo",
        fillColor: Color(0xffb3a2b9),
      ),
      keyboardType: TextInputType.emailAddress,
    ),
  )
  );
}

Widget NickName(){
  return(
    Container(
      padding: EdgeInsets.all(10),
      child: TextField(style: TextStyle(backgroundColor: Color.fromARGB(255, 214, 158, 233)),
      decoration: InputDecoration(
        hintText: "Ingresar NickName",
        fillColor: Color(0xffb3a2b9),
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
        MaterialPageRoute(builder: (context) => const Proyecto()),
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

