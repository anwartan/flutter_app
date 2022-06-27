import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tTvModel = testTvModel;

  final tTv = testTv;

  test('should be a subclass of Movie entity',() async {
    final result = tTvModel.toEntity();
    expect(result,tTv);
  });
}
