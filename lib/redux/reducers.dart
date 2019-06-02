import 'package:pruebasaprendisajeredux/model.dart';
import 'package:pruebasaprendisajeredux/redux/actions.dart';

EstadoApp appEstadoReducer(EstadoApp estado, accion){
  return EstadoApp(
      entradas: entradasReducer(estado.entradas, accion)
  );
}

List<Entrada> entradasReducer(List<Entrada> entradas, accion){

  if(accion is InsertarEntradaAccion){
    return[]
        ..addAll(entradas)
        ..add(Entrada(id: accion.id, texto: accion.texto));
  }

  if(accion is BorrarEntradaAccion){
    return List.unmodifiable(List.from(entradas)..remove(accion.entrada));
  }

  return entradas;
}