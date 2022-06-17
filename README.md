# Validate PDF content

Add some PDF files to `./data` first.

To test pdf validation run:

```sh
dart run
```

To run benchmarks:

```sh
dart run benchmark/benchmarks.dart
```

## Example

Having the following files for testing:

```sh
➜  dart_pdf_validator git:(main) ✗ la data 
total 133376
-rw-r--r--@ 1 tony.hristov  staff    25M Jun 17 18:51 10840.pdf
-rw-r--r--@ 1 tony.hristov  staff   147K Jun 17 18:51 AirForce_CardStatement_1.pdf
-rw-r--r--  1 tony.hristov  staff     0B Jun 17 18:51 empty.txt
-rw-r--r--@ 1 tony.hristov  staff   6.4M Jun 17 18:51 perl-all-en-5.8.5.pdf
-rw-r--r--@ 1 tony.hristov  staff   899K Jun 17 18:51 perl_tutorial.pdf
-rw-r--r--@ 1 tony.hristov  staff    13M Jun 17 18:51 postgresql-15-US.pdf
-rw-r--r--@ 1 tony.hristov  staff    20M Jun 17 18:51 ruby-3.1.2.tar.gz
```

Execute validation:

```sh
➜  dart_pdf_validator git:(main) ✗ dart run 
Building package executable... 
Built pdf_validator:pdf_validator.
Loaded pdf files: [File: './data/empty.txt', File: './data/ruby-3.1.2.tar.gz', File: './data/perl-all-en-5.8.5.pdf', File: './data/perl_tutorial.pdf', File: './data/10840.pdf', File: './data/postgresql-15-US.pdf', File: './data/AirForce_CardStatement_1.pdf']
Processing File: './data/empty.txt', size of 0B / 0MB
PdfBytesValidator File: './data/empty.txt' pdf=false / 0ms
PdfRegexValidator File: './data/empty.txt' pdf=false / 9ms
PdfStringValidator File: './data/empty.txt' pdf=false / 1ms
Processing File: './data/ruby-3.1.2.tar.gz', size of 20553628B / 20MB
PdfBytesValidator File: './data/ruby-3.1.2.tar.gz' pdf=false / 18ms
PdfRegexValidator File: './data/ruby-3.1.2.tar.gz' pdf=false / 62ms
PdfStringValidator File: './data/ruby-3.1.2.tar.gz' pdf=false / 79ms
Processing File: './data/perl-all-en-5.8.5.pdf', size of 6661943B / 6MB
PdfBytesValidator File: './data/perl-all-en-5.8.5.pdf' pdf=true / 0ms
PdfRegexValidator File: './data/perl-all-en-5.8.5.pdf' pdf=true / 394ms
PdfStringValidator File: './data/perl-all-en-5.8.5.pdf' pdf=true / 223ms
Processing File: './data/perl_tutorial.pdf', size of 920266B / 1MB
PdfBytesValidator File: './data/perl_tutorial.pdf' pdf=true / 0ms
PdfRegexValidator File: './data/perl_tutorial.pdf' pdf=true / 40ms
PdfStringValidator File: './data/perl_tutorial.pdf' pdf=true / 10ms
Processing File: './data/10840.pdf', size of 25959712B / 25MB
PdfBytesValidator File: './data/10840.pdf' pdf=true / 0ms
PdfRegexValidator File: './data/10840.pdf' pdf=true / 724ms
PdfStringValidator File: './data/10840.pdf' pdf=true / 243ms
Processing File: './data/postgresql-15-US.pdf', size of 14034580B / 13MB
PdfBytesValidator File: './data/postgresql-15-US.pdf' pdf=true / 0ms
PdfRegexValidator File: './data/postgresql-15-US.pdf' pdf=true / 129ms
PdfStringValidator File: './data/postgresql-15-US.pdf' pdf=true / 133ms
Processing File: './data/AirForce_CardStatement_1.pdf', size of 150506B / 0MB
PdfBytesValidator File: './data/AirForce_CardStatement_1.pdf' pdf=true / 0ms
PdfRegexValidator File: './data/AirForce_CardStatement_1.pdf' pdf=true / 1ms
PdfStringValidator File: './data/AirForce_CardStatement_1.pdf' pdf=true / 1ms
```

Benchmark validation, repeat 100 times each validator on the same set of files:

```sh
➜  dart_pdf_validator git:(main) ✗ dart run benchmark/benchmarks.dart
PdfBytesValidator(RunTime): 69765.86206896552 us.
PdfRegexValidator(RunTime): 46150485.0 us.
PdfStringValidator(RunTime): 20916699.0 us.
```
