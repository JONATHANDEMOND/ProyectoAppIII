import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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
        title: Text(
          "REGISTRO",
          style: TextStyle(
            fontSize: 24.0,  // Tamaño del texto
            fontWeight: FontWeight.bold,  // Texto en negrita
            color: Colors.black87,  // Color del texto
          ),
        ),
        backgroundColor: Colors.white,  // Color de fondo del AppBar
        elevation: 0,  // Sin sombra debajo del AppBar
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
        const Text(
  "Registra tus datos personales",
  style: TextStyle(
    fontSize: 20.0,  // Tamaño del texto
    fontWeight: FontWeight.bold,  // Texto en negrita
    color: Colors.black,  // Color del texto
    letterSpacing: 1.2,  // Espaciado entre caracteres
    fontStyle: FontStyle.italic,  // Estilo itálico
    decoration: TextDecoration.underline,  // Subrayado del texto
    decorationColor: Color.fromARGB(255, 40, 65, 84),  // Color del subrayado
    decorationThickness: 2.0,  // Grosor del subrayado
  ),
),

        CampoNick(context),
        CampoNombre(context),
        CampoEdad(context),
        CampoCorreo(context),
        CampoContrasenia(context),
        BotonGuardar(context)
      ],
    )),
  );
}

final TextEditingController _nick = TextEditingController();
Widget CampoNick(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: TextField(
      controller: _nick,
      decoration: InputDecoration(
        hintText: "Ingrese Nick Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    ),
  );
}


final TextEditingController _nombre = TextEditingController();
Widget CampoNombre(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: TextField(
      controller: _nombre,
      decoration: InputDecoration(
        hintText: "Ingrese Nombre",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    ),
  );
}

final TextEditingController _edad = TextEditingController();
Widget CampoEdad(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: TextField(
      controller: _edad,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Ingrese Edad",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    ),
  );
}

final TextEditingController _correo = TextEditingController();
Widget CampoCorreo(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: TextField(
      controller: _correo,
      decoration: InputDecoration(
        hintText: "Ingrese Correo",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    ),
  );
}

final TextEditingController _contrasenia = TextEditingController();
Widget CampoContrasenia(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: TextField(
      controller: _contrasenia,
      obscureText: true, // Para ocultar la contraseña
      decoration: InputDecoration(
        hintText: "Ingrese Contraseña",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    ),
  );
}

Widget BotonGuardar(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      registro(context);
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 53, 140, 211)),  // Color de fondo del botón
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),  // Color del texto del botón
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15.0)),  // Espaciado interno del botón
      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 18.0)),  // Estilo del texto del botón
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados
        ),
      ),
    ),
    child: Text("Registro"),
  );
}


Future<void> registro(context) async {
  try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _correo.text,
    password: _contrasenia.text,
  );
  //////////////navegacion///
  /////funcion gurdar//
  guardar();
    Navigator.push(context,MaterialPageRoute(builder: (context)=> Proyecto()));

} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
   
   alert01(context, const Text("La contraseña es muy debil"), const Text("Ingrese una contraseña fuerte"));
 
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    alert02(context, const Text("ERROR"), const Text("LA CUENTA YA EXISTE"));
 
  }
} catch (e) {
  print(e);
}
}
/////////////////////////////////////
///
Future<void> guardar() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("Usuarios/"+_nick.text);

await ref.set({
  "nick": _nick.text,
  "nombre": _nombre.text,
  "edad": _edad.text
  
});
}







////////////////alertas//////////////faltan
///
 void alert01(BuildContext context, Widget title, Widget content) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
void alert02(BuildContext context, Widget title, Widget content) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Proyecto()));
            },
            child: const Text("Sí"),
          ),
          TextButton(
            onPressed: () {
              print("Aquí debería ir una función (NO)");
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text("Cancelar"),
          ),
        ],
      );
    },
  );
}