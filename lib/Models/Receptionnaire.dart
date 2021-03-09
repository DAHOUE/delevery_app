class Receptionnaire {

  int _id;
  String _nomPrenoms;
  String _customerPhone;

  Receptionnaire(
      this._id,
      this._nomPrenoms,
      this._customerPhone,
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "_id": _id,
      "nomPrenoms": _nomPrenoms,
      "customerPhone": _customerPhone,
    };
    return map;
  }

  Receptionnaire.fromMap(Map<String, dynamic> map) {
    _id = map["_id"];
    _nomPrenoms = map["nomPrenoms"];
    _customerPhone = map["customerPhone"];
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
  String get customerPhone => _customerPhone;

  // ignore: unnecessary_getters_setters
  set customerPhone(String value) {
    _customerPhone = value;
  }

}
