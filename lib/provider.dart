import 'package:flutter/foundation.dart';
import 'dbHelper.dart';

class MyModelItem {
  final String id;
  final String number;
  final String name;

  MyModelItem({
    required this.id,
    required this.number,
    required this.name,
  });
}

class MyModelProvider with ChangeNotifier {
  List<MyModelItem> _item = [];

  List<MyModelItem> get item => _item;

  void addProduct(
    String pickNumber,
    String pickName,
  ) {
    final newProduct = MyModelItem(
      id: DateTime.now().toString(),
      number: pickNumber,
      name: pickName,
    );
    _item.add(newProduct);

    DBHelperFile.insert('file', {
      'id': newProduct.id,
      'number': newProduct.number,
      'name': newProduct.name,
    });
    notifyListeners();
  }

  Future<void> fetchAndSetFile() async {
    final dataList = await DBHelperFile.getData('file');
    _item = dataList
        .map(
          (item) => MyModelItem(
            id: item['id'],
            name: item['name'],
            number: item['number'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
