/// Support for doing something awesome.
///
/// More dartdocs go here.
library generators;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/table_generator.dart';

// export 'src/generators_base.dart';

// builder to make class files
Builder tableGeneratorBuilder(BuilderOptions options) =>
    SharedPartBuilder([TableAnnotationGenerator()], 'table');
    
// // builder to make class files
// Builder collectionGeneratorBuilder(BuilderOptions options) =>
//     SharedPartBuilder([CollectionGenerator()], 'collection');

