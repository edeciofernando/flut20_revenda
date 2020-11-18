import 'package:date_format/date_format.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiPropostas {
  final url =
      'https://api.sheety.co/58aad4af0eff6bb2d1446fe9d32d121a/revendaHerbie/propostas';

  saveProposta(carro, cliente, descricao) async {
    var reg = {
      "proposta": {
        "carroId": carro.id,
        "clienteId": cliente.id,
        "descricao": descricao,
        "data": formatDate(
            DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn])
      }
    };

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reg),
    );

    if (response.statusCode == 200) {
      var retorno = jsonDecode(response.body)['proposta'];
      return retorno['id'];
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }
}
