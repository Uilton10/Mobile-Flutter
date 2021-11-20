class Filme {
  int id = 0;
  String nome = "";
  String sinopse = "";
  String foto = "";

  Filme(this.id, this.nome, this.sinopse, this.foto);

  Filme.fromMap(Map map) {
    this.id = map["id"];
    this.nome = map["nome"];
    this.sinopse = map["sinopse"];
    this.foto = map["foto"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "nome": this.nome,
      "sinopse": this.sinopse,
      "foto": this.foto
    };

    if (this.id != null) {
      map["id"] = this.id;
    }

    return map;
  }
}
