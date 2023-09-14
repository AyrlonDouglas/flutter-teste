import 'dart:js_interop';

main() {
  var date = Data(
    ano: 1970,
    dia: 1,
  );

  print(date.toJS);
}

class Data {
  int? dia;
  int? mes;
  int? ano;

  // Data(this.dia, this.mes, this.ano) {}
  Data({this.dia, this.mes = 1, this.ano}) {}

  @override
  String toString() {
    return "${dia}/${mes}/${ano}";
  }
}
