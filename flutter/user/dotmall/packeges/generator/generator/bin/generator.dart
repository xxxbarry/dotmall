import 'package:generator/generator.dart';

void main(List<String> arguments) {
  var code = Generator.generate(
    table: "categories",
    fields: [
      Field("id", primary: true),
      Field("name", nullable: false),
      Field.text("description"),
    ],
  );
  print(code);
}
