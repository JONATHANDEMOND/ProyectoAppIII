import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_01/main.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Registro());
}
class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REGISTRO"),
      ),
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(context) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/image/1bkc.jpg'), fit: BoxFit.cover),
    ),
    padding: EdgeInsets.all(10),
    child: (Column(
      children: <Widget>[
        const Text("REGISTRO"),
        CampoCorreo(context),
        CampoContrasenia(context),
        BotonGuardar(context)
      ],
    )),
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
    ElevatedButton(onPressed: (){ registro(context);
      
    }, child: const Text("Registro"))
  );

}

Future<void> registro(context) async {
  try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _correo.text,
    password: _contrasenia.text,
  );
  //////////////navegacion///
    Navigator.push(context,MaterialPageRoute(builder: (context)=> Proyecto()));

} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
}
////////////////alertas//////////////faltan