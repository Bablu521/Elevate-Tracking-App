import 'dart:io';
import 'package:path/path.dart' as p;

Future<File> createTempFile(String name) async {
  final dir = Directory.systemTemp.createTempSync();
  final file = File(p.join(dir.path, name));
  await file.writeAsString("fake image content");
  return file;
}

