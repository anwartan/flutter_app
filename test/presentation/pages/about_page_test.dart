import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Image should display ', (WidgetTester tester) async {
    final image = find.byType(Image);

    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    expect(image, findsOneWidget);
  });
  testWidgets('Text description should display ', (WidgetTester tester) async {
    final image = find.text(
        "Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.");

    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    expect(image, findsOneWidget);
  });

}
