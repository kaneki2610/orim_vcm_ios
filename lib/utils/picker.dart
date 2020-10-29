import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

class PickerBuilder {
  BuildContext _context;

  PickerBuilder(BuildContext context): _context = context;

  showPickerModal<T>({List<T> pickerdata, int selected, Function(int index, T item) callback}) {
    Picker picker = new Picker(
        adapter: PickerDataAdapter<T>(pickerdata: pickerdata),
        changeToFirst: true,
        hideHeader: true,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        selecteds: <int>[selected],
        onConfirm: (Picker picker, List value) {
//          print(value.toString());
//          print(picker.getSelectedValues());
          callback(value[0], picker.getSelectedValues()[0]);
        }
    );
    picker.showDialog(_context);
  }

}