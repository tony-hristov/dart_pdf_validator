import 'dart:typed_data';

import 'package:collection/collection.dart';

Function listEquals = const ListEquality().equals;

abstract class PdfValidatorBase {
  bool isValidPdf(Uint8List content);
}
