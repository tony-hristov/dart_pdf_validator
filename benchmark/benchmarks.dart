import 'dart:io';
import 'dart:typed_data';

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:pdf_validator/pdf_validator/pdf_bytes_validator.dart';
import 'package:pdf_validator/pdf_validator/pdf_regex_validator.dart';
import 'package:pdf_validator/pdf_validator/pdf_string_validator.dart';
import 'package:pdf_validator/pdf_validator/pdf_validator_base.dart';

const _kIterations = 100;

void main() {
  PdfBytesValidatorBenchmark().report();
  PdfRegexValidatorBenchmark().report();
  PdfStringValidatorBenchmark().report();
}

abstract class Benchmark extends BenchmarkBase {
  final List<FileSystemEntity> files = <FileSystemEntity>[];
  final List<Uint8List> filesContent = <Uint8List>[];
  late PdfValidatorBase pdfBytesValdator;

  Benchmark(String name) : super(name) {
    final dir = Directory('./data');
    files.addAll(dir.listSync().toList());
    for (final fileEntry in files) {
      final File file = File(fileEntry.absolute.path);
      final Uint8List bytes = Uint8List.fromList(file.readAsBytesSync());
      filesContent.add(bytes);
    }
  }

  @override
  void exercise() {
    for (int i = 0; i < _kIterations; i++) {
      run();
    }
  }
}

class PdfBytesValidatorBenchmark extends Benchmark {
  PdfBytesValidatorBenchmark() : super('PdfBytesValidator') {
    pdfBytesValdator = PdfBytesValidator();
  }

  static void main() {
    PdfBytesValidatorBenchmark().report();
  }

  @override
  void run() {
    for (int i = 0; i < files.length; i++) {
      pdfBytesValdator.isValidPdf(filesContent[i]);
    }
  }
}

class PdfRegexValidatorBenchmark extends Benchmark {
  PdfRegexValidatorBenchmark() : super('PdfRegexValidator') {
    pdfBytesValdator = PdfRegexValidator('utf8');
  }

  static void main() {
    PdfRegexValidatorBenchmark().report();
  }

  @override
  void run() {
    for (int i = 0; i < files.length; i++) {
      pdfBytesValdator.isValidPdf(filesContent[i]);
    }
  }
}

class PdfStringValidatorBenchmark extends Benchmark {
  PdfStringValidatorBenchmark() : super('PdfStringValidator') {
    pdfBytesValdator = PdfStringValidator('utf8');
  }

  static void main() {
    PdfStringValidatorBenchmark().report();
  }

  @override
  void run() {
    for (int i = 0; i < files.length; i++) {
      pdfBytesValdator.isValidPdf(filesContent[i]);
    }
  }
}
