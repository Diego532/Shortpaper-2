import 'package:flutter/material.dart';
import './widgets/lista_doctores.dart';

void main() {
  runApp(
    MaterialApp(
        title: 'Vista de Doctores',
        home: ListaDoctores(),
        theme: ThemeData(primarySwatch: Colors.orange)),
  );
}
