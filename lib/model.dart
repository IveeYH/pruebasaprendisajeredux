import 'package:flutter/foundation.dart';

class Entrada{
  final int id;
  final String texto;

  Entrada({@required this.id, @required this.texto});
}

class EstadoApp{
  final List<Entrada> entradas;

  EstadoApp({@required this.entradas});

  EstadoApp.initialState() : entradas = List.unmodifiable(<Entrada>[]);
}