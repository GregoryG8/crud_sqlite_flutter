import 'package:crud_sqlite_flutter/data_base/crud.dart';
import 'package:crud_sqlite_flutter/data_base/tables.dart';

class Diary extends Crud {
  int id;
  String type;
  String enterCode;

  Diary({
    this.id = 0,
    this.enterCode = "",
    this.type = "",
  }) : super(diaryTable);

  @override
  String toString() {
    return "Id: $id tipo: $type";
  }

  Diary toObject(Map<String, dynamic> data) {
  return Diary(
    id: data["id"],
    type: data["type"],
    enterCode: data["enterCode"],
  );
}

  Map<String, dynamic> toMap() {
  return {
    "id": id > 0 ? id : null,
    "type": type,
    "enterCode": enterCode,
  };
}

  save() async {
    return await ((id > 0) ? update(toMap()) : create(toMap()));
  }

  remove() async {
    await delete(id);
  }

  Future<List<Diary>> getDiaries() async {
    var result = await query("SELECT * FROM $diaryTable");
    return _getListObject(result);
  }

  List<Diary> _getListObject(parsed) {
    return (parsed as List).map((map) => toObject(map)).toList();
  }
}
