import 'dart:typed_data';
import 'package:pdf_validator/pdf_validator/pdf_validator_base.dart';

/// Holds ASCII codes of magic-number "%PDF"
const _kPDFMarkup = [37, 80, 68, 70];

/// Holds ASCII codes of end-of-file marker "%%EOF"
const _kEOFMarkup = [37, 37, 69, 79, 70];

/// Holds ASCII code for percentage sign
const _kPrct = 37;

/// Limits how many bytes to read looking for %PDF
const _kMaxBytesRead = 10000;

class PdfBytesValidator implements PdfValidatorBase {
  @override
  bool isValidPdf(Uint8List content) {
    return _endsWithEOFMarkup(content) || _containsPDFMarkup(content);
  }

  bool _endsWithEOFMarkup(Uint8List content) {
    final mLen = _kEOFMarkup.length;
    final last5Bytes = _getBytes(content, mLen, 0, true);
    return last5Bytes != null && listEquals(last5Bytes, Uint8List.fromList(_kEOFMarkup));
  }

  bool _containsPDFMarkup(Uint8List content) {
    final len = content.lengthInBytes;
    final mLen = _kPDFMarkup.length;

    int idx = 0;
    while (idx < len && idx < _kMaxBytesRead) {
      final subset = _getBytes(content, mLen, idx);
      if (subset == null) {
        return false;
      }

      if (listEquals(subset, Uint8List.fromList(_kPDFMarkup))) {
        return true;
      }

      if (subset.lastIndexOf(_kPrct) > 0) {
        idx++;
      } else {
        idx += mLen;
      }
    }
    return false;
  }

  Uint8List? _getBytes(Uint8List content, int count, int startIdx, [bool atEnd = false]) {
    final len = content.lengthInBytes;
    if (startIdx + count > len) {
      return null;
    }
    final builder = BytesBuilder();
    if (atEnd) {
      builder.add(content.skip(len - count).take(count).toList());
    } else {
      builder.add(content.skip(startIdx).take(count).toList());
    }
    return builder.toBytes();
  }
}
