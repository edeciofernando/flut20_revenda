import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:revenda_herbie/apis/api_carros.dart';
import 'package:revenda_herbie/classes/carro.dart';

class CarrosBloc extends BlocBase {
  final _carrosController = StreamController<List<Carro>>();
  Stream<List<Carro>> get outCarros => _carrosController.stream;

  ApiCarros apiCarros = ApiCarros();

  void buscaCarros() async {
    final carros = await apiCarros.getCarros();
    _carrosController.sink.add(carros);
  }

  void buscaCarrosDestaque() async {
    _carrosController.sink.add(null);
    final carros = await apiCarros.getCarrosDestaque();
    _carrosController.sink.add(carros);
  }

  void buscaCarrosPesquisa(String palavra) async {
    _carrosController.sink.add(null);
    final carros = await apiCarros.getCarrosPesquisa(palavra);
    _carrosController.sink.add(carros);
  }

  @override
  void dispose() {
    _carrosController.close();
  }
}
