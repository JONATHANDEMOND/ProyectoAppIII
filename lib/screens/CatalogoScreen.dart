import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_01/main.dart';

void main(){
  runApp(const Catalogo());
}
class Catalogo extends StatelessWidget {
  const Catalogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:Lista(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Map<dynamic, dynamic>> peliculasList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    /////////////////////////////////////////
    /// Función con el objetivo de traer los datos
    /////////////////////////////////////////
    
    DatabaseReference productoRef = FirebaseDatabase.instance.ref('peliculas');
    productoRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
     
      updateProductList(data);

     
    });
    
  }

  void updateProductList(dynamic data) {
    if (data != null) {
      List<Map<dynamic, dynamic>> tempList = [];
      data.forEach((key, value) {
        //////////////////////////////////////////
        /// Se asigna la clave y valor a la lista temporal
        //////////////////////////////////////////
        if ( value['pelicula']!= null ){
        tempList.add({"pelicula": value['pelicula'], "anio": value['año'], "img":value['Imagen'], "titulo":value['titulo'], "video":value['video']});
         print(data);
        }
      });

      setState(() {
        peliculasList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Peliculas'),
      ),
      body: ListView.builder(
        itemCount: peliculasList.length,
        itemBuilder: (context, index) {
          return ListTile(
            //////////////////////////////////////
            /// Se manda a imprimir los valores solicitados
            //////////////////////////////////////
            
            title: Text('${peliculasList[index]["pelicula"]} _${peliculasList[index]["titulo"]}'),
            subtitle: Text('${peliculasList[index]["imagen"]}'),
            
          );
        },
      ),
    );
  }
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