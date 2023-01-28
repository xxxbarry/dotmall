/// Support for doing something awesome.
///
/// More dartdocs go here.
library auto_sdk_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/table_generator.dart';

// export 'src/auto_sdk_generator_base.dart';

// builder to make class files
Builder tableGeneratorBuilder(BuilderOptions options) =>
    SharedPartBuilder([TableAnnotationGenerator()], 'table');
    
// // builder to make class files
// Builder collectionGeneratorBuilder(BuilderOptions options) =>
//     SharedPartBuilder([CollectionGenerator()], 'collection');

