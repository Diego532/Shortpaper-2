import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myonlinedoctor_frontend/modules/specialty.dart';
import '../modules/doctor.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class ListaDoctores extends StatefulWidget {
  //const ListaDoctores({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}

//

class MyAppState extends State<ListaDoctores> {
  late Future<List<Doctor>>
      doctores1; //late to field means that the field will be initialized when you use it for the first timeList<Doctor> list .

  List<Doctor> list = [];

  Future<List<Doctor>> _getDoctores() async {
    // es una funcion asincrona. espera a que se resuelva la peticion
    final response = await http
        .get(Uri.parse("https://gentle-river-68727.herokuapp.com/doctors"));

    List<Doctor> doctores = <Doctor>[];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonDoctores = jsonDecode(
          body); // toma la informacion de un string y la transforma en un json valido

      print(jsonDoctores);
      for (var doctor in jsonDoctores) {
        print(doctor["name"]);
        print(doctor["last_name"]);

        doctores.add(Doctor("lklk", doctor["name"], doctor["last_name"],
            [Specialty("psiquiatra")]));
      }
    } else {
      throw Exception("Fallo la conexion");
    }

    return doctores;
  }

  @override
  void initState() {
    super.initState();
    doctores1 = _getDoctores();
  }

  transformar() async {
    doctores1 = _getDoctores();
    List<Doctor> list = await doctores1;
    return list;
  }

  // lista de ejemplo de doctores
  // List<Doctor> doctores = [
  //   Doctor('jsdbfosdbvs', 'Diego', 'Bastardo', Specialty('Cardiologo')),
  //   Doctor('jsdbfosdbvs', 'Luis', 'Bastardo', Specialty('Neurocirujano')),
  //   Doctor('jsdbfosdbvs', 'Kamila', 'Reyes', Specialty('Dentista'))
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Lista de Doctores', textAlign: TextAlign.center),
          leading: IconButton(
            //error
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              // error
              icon: const Icon(Icons.search),
              onPressed: () {},
            )
          ]
          //iconTheme: Icons.search
          ),
      body: FutureBuilder(
        future: doctores1,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return const Text('data');
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Text("Error");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      // elementList(context, doctores)
    );
  }
}

Widget elementList(BuildContext context, List<Doctor> doctores) {
  return ListView.builder(
      itemCount: doctores.length,
      itemBuilder: ((context, index) {
        return ListTile(
          title: Text("${doctores[index].name} ${doctores[index].lastname}"),
          subtitle: Text(doctores[index].specialty[0].specialtyname),
          leading:
              CircleAvatar(child: Text(doctores[index].name.substring(0, 1))),
        );
      }));
}
