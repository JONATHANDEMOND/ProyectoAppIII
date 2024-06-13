import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proyecto_01/screens/CatalogoScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyecto_01/screens/RegistroScreen.dart';

Future<void> main () async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Monkey Pelis"),
        backgroundColor: Colors.white70,
      ),
      body: Cuerpo(context),
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
          CampoCorreo(context),
          CampoContrasenia(context),
          BotonGuardar(context),
          BotonRegistro(context)

    ],

  ),
  );
}

final TextEditingController _correo = TextEditingController();

Widget CampoCorreo(context){
  return Container(
    padding: EdgeInsets.all(10),
    child: (
      TextField(
        controller: _correo,
      decoration: const InputDecoration(
        hintText: "Ingrese Correo"),
    )
    
    ),
  );
}
final TextEditingController _contrasenia= TextEditingController();
Widget CampoContrasenia(context){
   return Container(
    padding: EdgeInsets.all(10),
     child: (
    TextField(
        controller: _contrasenia,
      decoration: const InputDecoration(
        hintText: "Ingrese Contraseña"),
       )
     
       ),
   );
}
Widget BotonGuardar(context){
  return(
    FilledButton(onPressed: (){ login(context);
      
     
    }, child: const Text("Login"))
  );

}
Widget BotonRegistro(context){
  return(
    ElevatedButton(
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber)),
      onPressed: (){
        Navigator.push(context, 
        MaterialPageRoute(builder: 
        (context)=> Registro()));
      }, child: Text("Ir al Registro"))
  );
}

Future<void> login(context) async {
  try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _correo.text,
    password: _contrasenia.text
  );
  ////////////////////navegacion
   Navigator.push(context,MaterialPageRoute(builder: (context)=> Catalogo()));

} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}

}

