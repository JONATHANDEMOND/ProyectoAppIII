import 'package:flutter/material.dart';
import 'package:proyecto_01/main.dart';

void main() {
  runApp(Catalogo());
}

class Catalogo extends StatelessWidget {
  const Catalogo({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(BuildContext context) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(16.0),
        child: const Text(
          "PELIS",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: EdgeInsets.all(16.0),
        child: const Text(
          "Escoge tu Pelicula",
          style: TextStyle(fontSize: 18),
        ),
      ),
      Expanded(
        child: GridView.count(
          crossAxisCount: 2, // Número de columnas
          crossAxisSpacing: 4.0, // Espaciado entre columnas
          mainAxisSpacing: 1.0, // Espaciado entre filas
          children: <Widget>[
            Image.network("https://4kwallpapers.com/images/walls/thumbs_3t/16995.jpg"),
            Image.network("https://4kwallpapers.com/images/walls/thumbs_3t/17003.jpg"),
            Image.network("https://4kwallpapers.com/images/walls/thumbs_3t/16830.jpg"),
            Image.network("https://4kwallpapers.com/images/walls/thumbs_3t/16729.jpeg"),
            Image.network("https://4kwallpapers.com/images/walls/thumbs_3t/16577.jpg"),
            Image.network("https://4kwallpapers.com/images/walls/thumbs_3t/16572.jpg"),
            // Agrega más imágenes si es necesario
          ],
        ),
      ),

      Boton1(context)
    ],
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
    child: const Text("SALIR"),
  );
}