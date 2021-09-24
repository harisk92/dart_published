import 'dart:async';

import 'package:published/published.dart';
import 'package:published_gen/src/lib/published_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  final reader =
      await initializeLibraryReaderForDirectory('test', 'source_gen_src.dart');

  initializeBuildLogTracking();

  testAnnotatedElements<Published>(reader, PublishedGenerator());
}
