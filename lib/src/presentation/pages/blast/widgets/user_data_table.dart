import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../domain/entities/blast_entity.dart';

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    required List<BlastEntity> userData,
  }) : _userData = userData;

  final List<BlastEntity> _userData;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _userData.length) {
      return const DataRow(
        cells: [],
      );
    }
    final item = _userData[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
          Text(
            item.nama,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            item.posisi,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            item.hari,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            item.jam,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            item.group,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            item.linkGroup,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            item.hp,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            item.undangan,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            item.status,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(BlastEntity d) getField, bool ascending) {
    _userData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
  }
}
