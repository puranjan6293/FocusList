import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  Person({
    required this.name,
    required this.dueTime,
  });
  @HiveField(0)
  String name;

  @HiveField(2)
  DateTime dueTime;
}
