import 'package:flutter/material.dart';

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    required List<Map<String, dynamic>> userData,
  }) : _userData = userData;

  final List<Map<String, dynamic>> _userData;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _userData.length) {
      return const DataRow(
        cells: [],
      );
    }

    List<DataRow> buildRows() {
      return _userData.map<DataRow>((Map<String, dynamic> item) {
        return DataRow(
          cells: item.keys.map<DataCell>((String key) {
            return DataCell(
              Text(item[key].toString()),
            );
          }).toList(),
        );
      }).toList();
    }

    return buildRows()[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(
      Comparable<T> Function(Map<String, dynamic> d) getField, bool ascending) {
    _userData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
  }
}
