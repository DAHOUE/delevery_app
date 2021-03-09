class Order {

  int _id;
  String _nomPrenoms;
  String _nomProduit;
  String _orderStat;
  String _customerPhone;
  int _total;

  Order(
      this._id,
      this._nomPrenoms,
      this._nomProduit,
      this._orderStat,
      this._customerPhone,
      this._total,
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "_id": _id,
      "nomPrenoms": _nomPrenoms,
      "nomProduit": _nomProduit,
      "etatLivraison": _orderStat,
      "tel": _customerPhone,
      "coutTotal": _total,
    };
    return map;
  }

  Order.fromMap(Map<String, dynamic> map) {
    _id = map["_id"];
    _nomPrenoms = map["nomPrenoms"];
    _nomProduit = map["nomProduit"];
    _orderStat = map["etatLivraison"];
    _customerPhone = map["tel"];
    _total = map["coutTotal"];
  }

  // ignore: unnecessary_getters_setters
  int get id => _id;

  // ignore: unnecessary_getters_setters
  set id(int value) {
    _id = value;
  }

  // ignore: unnecessary_getters_setters
  String get nomPrenoms => _nomPrenoms;

  // ignore: unnecessary_getters_setters
  set nomPrenoms(String value) {
    _nomPrenoms = value;
  }

  // ignore: unnecessary_getters_setters
  String get nomProduit => _nomProduit;

  // ignore: unnecessary_getters_setters
  set nomProduit(String value) {
    _nomProduit = value;
  }

  // ignore: unnecessary_getters_setters
  String get orderStat => _orderStat;

  // ignore: unnecessary_getters_setters
  set orderStat(String value) {
    _orderStat = value;
  }

  // ignore: unnecessary_getters_setters
  String get customerPhone => _customerPhone;

  // ignore: unnecessary_getters_setters
  set customerPhone(String value) {
    _customerPhone = value;
  }

  // ignore: unnecessary_getters_setters
  int get total => _total;

  // ignore: unnecessary_getters_setters
  set total(int value) {
    _total = value;
  }

}
