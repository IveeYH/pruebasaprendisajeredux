import 'package:pruebasaprendisajeredux/model.dart';

class InsertarEntradaAccion{
  final String texto;
  static int _id = 0;

  InsertarEntradaAccion(this.texto){
    _id++;
  }

  int get id => _id;
}

class BorrarEntradaAccion{
  final Entrada entrada;

  BorrarEntradaAccion(this.entrada);
}