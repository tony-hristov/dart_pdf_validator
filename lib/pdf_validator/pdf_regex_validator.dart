import 'dart:convert';
import 'dart:typed_data';
import 'package:pdf_validator/pdf_validator/pdf_validator_base.dart';

class PdfRegexValidator implements PdfValidatorBase {
  final String charset;
  PdfRegexValidator(this.charset);

  @override
  bool isValidPdf(
    Uint8List content,
  ) {
    final encoding = Encoding.getByName(charset) ?? latin1;
    final text = encoding.decode(content);
    return text.contains(RegExp('%PDF(\\S|\\s)*%%EOF'));
  }
}
