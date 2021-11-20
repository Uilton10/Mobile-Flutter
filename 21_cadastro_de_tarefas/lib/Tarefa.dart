class Tarefa {
  int id = 0;
  String title = "";
  String description = "";

  Tarefa(this.id, this.title, this.description);

  Tarefa.fromMap(Map map) {
    this.id = map["id"];
    this.title = map["title"];
    this.description = map["description"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "title": this.title,
      "description": this.description
    };

    if (this.id != null) {
      map["id"] = this.id;
    }

    return map;
  }
}
