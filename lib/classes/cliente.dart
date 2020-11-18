class Cliente {
  final int id;
  final String nome;
  final String email;

  Cliente(this.id, this.nome, this.email);

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(json['id'], json['nome'], json['email']);
  }
}
