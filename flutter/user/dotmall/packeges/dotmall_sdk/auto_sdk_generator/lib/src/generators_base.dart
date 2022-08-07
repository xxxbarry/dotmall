import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class CollectionGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    var buffer = StringBuffer();
    // get generec type of variable List<T>, get T name
    // var type = library.allClasses.firstWhere((cls) =>
    //     cls.name == 'List' &&
    //     cls.genericTypeParameters.isNotEmpty &&
    //     cls.genericTypeParameters.first.name == 'T');
    buffer.writeln('// library');
    // get all classes where type is Model
    library.classes
        .where(
      (element) => element.allSupertypes.any((type) => type.name == 'Model'),
    )
        .forEach((element) {
      buffer.writeln('//class ${element.name} extends Model {');
      element.fields.forEach((field) {
        buffer.writeln('//  var ${field.name} = ${field.name};');
      });
      buffer.write("///////");
    });

    return buffer.toString();

    var name = "library";
    return '''
    class ${name}Collection extends Collection {
      ${name}Collection(String path) : super(path);

      ${name}Collection.fromJson(String path, Map<String, dynamic> json) : super.fromJson(path, json);

      @override
      ${name}Collection copy() => ${name}Collection(path);
    }
    ''';
  }
}
