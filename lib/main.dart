import 'package:flutter/material.dart';
import 'package:pruebasaprendisajeredux/model.dart';
import 'package:pruebasaprendisajeredux/redux/actions.dart';
import 'package:pruebasaprendisajeredux/redux/reducers.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final Store<EstadoApp> estado = Store<EstadoApp>(
        appEstadoReducer,
        initialState: EstadoApp.initialState(),
      );

      return StoreProvider<EstadoApp>(
        store: estado,
        child: MaterialApp(
          title: 'Tontogilipo',
          home: MyHomePage(),
        ),
      );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ArnauFantasmón'),
      ),
      body: StoreConnector(
          converter: (Store<EstadoApp> estado) => _ViewModel.crear(estado),
          builder: (BuildContext context, _ViewModel viewModel) => Column(
            children: <Widget>[
              InsertarEntradaWidget(viewModel),
              Expanded(child: ListaEntradasWidget(viewModel),)
            ],
          ),
      ),
    );
  }
}

class InsertarEntradaWidget extends StatefulWidget{
  final _ViewModel model;
  
  InsertarEntradaWidget(this.model);
  
  @override
  _InsertarEntradaState createState() => _InsertarEntradaState();
}

class _InsertarEntradaState extends State<InsertarEntradaWidget>{
  final TextEditingController controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      onSubmitted: (String s){
        widget.model.alInsertarEntrada(s);
        controlador.text = '';
      },
    );
  }
}

class ListaEntradasWidget extends StatelessWidget{
  final _ViewModel model;

  ListaEntradasWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: model.entradas
        .map((Entrada entrada) => ListTile(
          title: Text(entrada.texto),
          subtitle: Text(entrada.id.toString()),
          leading: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => model.alBorrarEntrada(entrada),
          ),
        )).toList()
    );
  }
}

class _ViewModel{

  final List<Entrada> entradas;
  final Function(String) alInsertarEntrada;
  final Function(Entrada) alBorrarEntrada;

  _ViewModel({
    this.entradas,
    this.alInsertarEntrada,
    this.alBorrarEntrada,
  });

  factory _ViewModel.crear(Store<EstadoApp> estado){
    _alInsertarEntrada(String texto){
      estado.dispatch(InsertarEntradaAccion(texto));
    }

    _alBorrarEntrada(Entrada entrada){
      estado.dispatch(BorrarEntradaAccion(entrada));
    }

    return _ViewModel(
      entradas: estado.state.entradas,
      alInsertarEntrada: _alInsertarEntrada,
      alBorrarEntrada: _alBorrarEntrada,
    );
  }

}
