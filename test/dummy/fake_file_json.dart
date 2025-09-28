import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FakeAssetBundle extends CachingAssetBundle {
  final Map<String, String> files;
  FakeAssetBundle(this.files);

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    if (!files.containsKey(key)) {
      throw FlutterError('File not found: $key');
    }
    return files[key]!;
  }

  @override
  Future<ByteData> load(String key) async {
    if (!files.containsKey(key)) {
      throw FlutterError('File not found: $key');
    }
    final stringData = files[key]!;
    final bytes = Uint8List.fromList(stringData.codeUnits);
    return ByteData.view(bytes.buffer);
  }
}
