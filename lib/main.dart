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
        title: Text(
          "Monkey Pelis",
          style: TextStyle(
            color: Colors.black87,  // Color del texto del título
            fontSize: 24.0,  // Tamaño del texto del título
            fontWeight: FontWeight.bold,  // Texto en negrita
          ),
        ),
        backgroundColor: Colors.white,  // Color de fondo del appbar
        elevation: 0,  // Sin sombra debajo del appbar
      ),
      body: Cuerpo(context),
    );
  }
}



Widget Cuerpo(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/image/1bkc.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Login",
          style: TextStyle(
            fontSize: 50,  // Aumentamos el tamaño del texto a 40
            fontWeight: FontWeight.bold,  // Texto en negrita para más énfasis
            color: Color.fromARGB(255, 236, 12, 30),  // Cambiamos el color a un tono rojo
          ),
        ),
        SizedBox(height: 20),  // Espacio entre el título y los campos
        CampoCorreo(context),
        SizedBox(height: 10),  // Espacio adicional entre los campos
        CampoContrasenia(context),
        SizedBox(height: 20),  // Espacio antes del botón de guardar
        BotonGuardar(context),
        SizedBox(height: 10),  // Espacio entre el botón de guardar y el de registro
        BotonRegistro(context),
      ],
    ),
  );
}

final TextEditingController _correo = TextEditingController();
Widget CampoCorreo(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(10),
    child: TextField(
      controller: _correo,
      decoration: InputDecoration(
        hintText: "Ingrese Correo",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
        prefixIcon: Icon(Icons.email, color: Colors.grey),
      ),
    ),
  );
}

final TextEditingController _contrasenia = TextEditingController();
Widget CampoContrasenia(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(10),
    child: TextField(
      controller: _contrasenia,
      obscureText: true,  // Para ocultar la contraseña
      decoration: InputDecoration(
        hintText: "Ingrese Contraseña",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
        prefixIcon: Icon(Icons.lock, color: Colors.grey),
      ),
    ),
  );
}

Widget BotonGuardar(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      login(context);
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: Colors.blue,  // Color del texto del botón
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados
      ),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),  // Espaciado interno
    ),
    child: Text(
      "Login",
      style: TextStyle(fontSize: 18.0),  // Tamaño del texto
    ),
  );
}

Widget BotonRegistro(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Registro()),
      );
    },
    style: TextButton.styleFrom(
      backgroundColor: Colors.amber,  // Color de fondo del botón
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados
      ),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),  // Espaciado interno
    ),
    child: Text(
      "Ir al Registro",
      style: TextStyle(
        color: Colors.black87,  // Color del texto
        fontSize: 18.0,  // Tamaño del texto
      ),
    ),
  );
}

Future<void> login(BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _correo.text,
      password: _contrasenia.text,
    );
    
    // Navegación a la pantalla Catálogo
    Navigator.push(context, MaterialPageRoute(builder: (context) => Peliculas()));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      alert(context, const Text("Error"), const Text("No se encontró un usuario con ese correo."));
    } else if (e.code == 'wrong-password') {
      alert(context, const Text("Error"), const Text("Contraseña incorrecta para ese usuario."));
    }
  } catch (e) {
    print(e);
    alert(context, const Text("Error"), const Text("Ocurrió un error inesperado. Por favor, inténtelo de nuevo."));
  }
}
////////////////alertas//////////////faltan
///*


void alert(BuildContext context, Widget title, Widget content) {
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