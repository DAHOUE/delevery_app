class Livreur {

  int _id;
  String _login;
  String _password;

  Livreur (
      this._id,
      this._login,
      this._password,
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "_id": _id,
      "login": _login,
      "password": _password,
    };
    return map;
  }

  Livreur.fromMap(Map<String, dynamic> map) {
    _id = map["_id"];
    _login = map["login"];
    _password = map["password"];
  }

  // ignore: unnecessary_getters_setters
  int get id => _id;

  // ignore: unnecessary_getters_setters
  set id(int value) {
    _id = value;
  }

  // ignore: unnecessary_getters_setters
  String get login => _login;

  // ignore: unnecessary_getters_setters
  set login(String value) {
    _login = value;
  }

  // ignore: unnecessary_getters_setters
  String get password => _password;

  // ignore: unnecessary_getters_setters
  set password(String value) {
    _password = value;
  }

}
