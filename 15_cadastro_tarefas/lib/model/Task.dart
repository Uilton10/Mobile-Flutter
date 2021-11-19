import 'package:teste01/helper/TaskHelper.dart';

class Task {
  int id = 0 ;
  String descricao = "";
  Task( this.descricao);
  Task.fromMap(Map map) {
    this.id = map["id"];
    this.descricao = map["descricao"];
  }
  Map toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "descricao": this.descricao,
    };

    if (this.id != null) {
      map["id"] = this.id;
    }

    return map;
  }
}
