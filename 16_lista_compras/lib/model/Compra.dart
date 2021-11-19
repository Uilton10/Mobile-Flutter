import 'package:teste01/helper/CompraHelper.dart';

class Compra {
  int id = 0 ;
  String mercadoria = "";
  int quantidade = 0;
  Compra( this.mercadoria, this.quantidade);
  Compra.fromMap(Map map) {
    this.id = map["id"];
    this.mercadoria = map["mercadoria"];
    this.quantidade = map["quantidade"];
  }
  Map toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "mercadoria": this.mercadoria,
      "quantidade": this.quantidade,
    };

    if (this.id != null) {
      map["id"] = this.id;
    }

    return map;
  }
}
