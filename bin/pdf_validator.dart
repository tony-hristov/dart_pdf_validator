import 'dart:io';

import 'dart:typed_data';

import 'package:pdf_validator/pdf_validator/pdf_bytes_validator.dart';
import 'package:pdf_validator/pdf_validator/pdf_regex_validator.dart';

void main() {
  final dir = Directory('./data');
  final List<FileSystemEntity> files = dir.listSync().toList();
  final List<Uint8List> filesContent = <Uint8List>[];
  for (int i = 0; i < files.length; i++) {
    final fileEntry = files[i];
    final File file = File(fileEntry.absolute.path);
    final Uint8List bytes = Uint8List.fromList(file.readAsBytesSync());
    filesContent.add(bytes);
  }

  print('Loaded pdf files: $files');

  final pdfBytesValdator = PdfBytesValidator();
  final pdfRegexValdator = PdfRegexValidator('utf8');
  final pdfStringValdator = PdfRegexValidator('utf8');
  final stopwatch = Stopwatch();

  for (int i = 0; i < files.length; i++) {
    final fileEntry = files[i];
    final fileContent = filesContent[i];
    final fileLen = fileContent.lengthInBytes;

    print('Processing $fileEntry, size of ${fileLen}B / ${(fileLen / 1024 / 1024).round()}MB');

    bool isValid = false;
    int ms = 0;

    ms = _measure(() => isValid = pdfBytesValdator.isValidPdf(fileContent));
    print('PdfBytesValidator $fileEntry pdf=$isValid / ${ms}ms');

    ms = _measure(() => isValid = pdfRegexValdator.isValidPdf(fileContent));
    print('PdfRegexValidator $fileEntry pdf=$isValid / ${ms}ms');

    ms = _measure(() => isValid = pdfStringValdator.isValidPdf(fileContent));
    print('PdfStringValidator $fileEntry pdf=$isValid / ${ms}ms');
  }
}

int _measure(Function f) {
  final sw = Stopwatch()..start();
  f();
  sw.stop();
  return sw.elapsedMilliseconds;
}
