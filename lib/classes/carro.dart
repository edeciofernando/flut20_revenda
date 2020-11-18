class Carro {
  final int id;
  final String modelo;
  final String marca;
  final int ano;
  final double preco;
  final bool destaque;
  final String foto;

  Carro(this.id, this.modelo, this.marca, this.ano, this.preco, this.destaque,
      this.foto);

  factory Carro.fromJson(Map<String, dynamic> json) {
    return Carro(json['id'], json['modelo'], json['marca'], json['ano'],
        json['preco'].toDouble(), json['destaque'], json['foto']);
  }
}
