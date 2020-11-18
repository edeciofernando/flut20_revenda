import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:revenda_herbie/classes/carro.dart';

class ApiCarros {
  final url =
      'https://api.sheety.co/58aad4af0eff6bb2d1446fe9d32d121a/revendaHerbie/carros';

  // getCarros() async {
  //   var response = await http.get(url);
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');

  //   print({json.decode(response.body)['carros']});
  // }

  getCarros() async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var lista = json.decode(response.body)['carros'];
      List<Carro> carros =
          lista.map<Carro>((carro) => Carro.fromJson(carro)).toList();
//      print(carros);
      return carros;
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }

  getCarrosDestaque() async {
    var response = await http.get(url + '?filter[destaque]=true');

    if (response.statusCode == 200) {
      var lista = json.decode(response.body)['carros'];
      List<Carro> carros =
          lista.map<Carro>((carro) => Carro.fromJson(carro)).toList();
//      print(carros);
      return carros;
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }

  getCarrosPesquisa(String palavra) async {
    var response = await http.get(url + '?filter[modelo]=' + palavra);

    if (response.statusCode == 200) {
      var lista = json.decode(response.body)['carros'];
      List<Carro> carros =
          lista.map<Carro>((carro) => Carro.fromJson(carro)).toList();
//      print(carros);
      return carros;
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }
}
