import 'package:hive_completion/data/constructor.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'generate.g.dart';

@HiveType(typeId: hiveTypeID)
class HiveTypeData extends HiveObject {
  HiveTypeData(this.title, this.author, this.content, {this.id=0});

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String author;

  @HiveField(2)
  final String content;

  final int id;
}