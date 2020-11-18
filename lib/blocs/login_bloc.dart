import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:revenda_herbie/classes/cliente.dart';

class LoginBloc extends BlocBase {
  final _clienteController = StreamController<Cliente>();
  Stream<Cliente> get outCliente => _clienteController.stream;

  void loginCliente(cliente) {
    _clienteController.sink.add(cliente);
  }

  @override
  void dispose() {
    _clienteController.close();
  }
}
