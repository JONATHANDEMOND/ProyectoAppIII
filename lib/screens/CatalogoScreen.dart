import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyecto_01/screens/PlayScreen.dart';
import 'package:proyecto_01/screens/SeriesScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Peliculas());
}

class Peliculas extends StatelessWidget {
  const Peliculas({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Lista(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Map<String, dynamic>> peliculasList = [];
  int indice = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final response = await http.get(Uri.parse('https://jonathandemond.github.io/apipelis/peliculas.json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        updateProductList(data);
      } else {
        throw Exception('El JSON no es una lista');
      }
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  void updateProductList(List<dynamic> data) {
    List<Map<String, dynamic>> tempList = [];

    data.forEach((element) {
      tempList.add({
        "titulo": element['titulo'],
        "anio": element['anio'],
        "imagen": element['img'],
        "video": element['video'],
      });
    });

    setState(() {
      peliculasList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [Cuerpo(), Series()];
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Películas',
        style: TextStyle(
    fontSize: 20.0,  // Tamaño del texto
    fontWeight: FontWeight.bold,  // Texto en negrita
    color: Colors.black,  // Color del texto
    letterSpacing: 1.2,  // Espaciado entre caracteres
    fontStyle: FontStyle.italic,  // Estilo itálico
    
  ),),
      ),
      body: screens[indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,
        onTap: (value) {
          setState(() {
            indice = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Pelis"),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movie"),
        ],
      ),
    );
  }

  Widget Cuerpo() {
    return ListView.builder(
      itemCount: peliculasList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.network(
              peliculasList[index]["imagen"],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(
              '${peliculasList[index]["titulo"]}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${peliculasList[index]["anio"]}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(videoUrl: peliculasList[index]["video"]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
