import 'package:flutter_test/flutter_test.dart';
import 'package:bible_chichewa/bible_chichewa.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final bible = Bible();
  await bible.init();

  test('Loading Bible Books', () {
    expect(bible.getBooks().length, 66);
  });

  test('Chapter Checking', () async {
    for (var book in BOOK.values) {
      expect((await bible.getChapter(book, 1)).length > 1, true);
    }
  });

  test('Verse Check', () async {
    for (var book in BOOK.values) {
      expect((await bible.getVerses(book, 1, 1, 2)).length > 1, true);
    }
  });
}
