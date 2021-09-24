library published;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/lib/published_generator.dart';

Builder published(BuilderOptions options) {
  return PartBuilder(
    [PublishedGenerator()],
    ".published.dart",
  );
}
