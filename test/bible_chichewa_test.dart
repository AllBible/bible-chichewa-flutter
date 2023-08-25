import 'package:flutter_test/flutter_test.dart';
import 'package:bible_chichewa/bible_chichewa.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final bible = Bible();
  await bible.init();

  test('Loading Bible Books', () {
    expect(bible.getBooks().length, 66);
  });

  test('Check Missing Verses', () async {
    expect((await bible.getChapter(BOOK.matthew, 17)).length > 1, true);
    expect((await bible.getChapter(BOOK.matthew, 18)).length > 1, true);
    expect((await bible.getChapter(BOOK.john, 5)).length == 47, true);
  });

  test('Bible Check', () async {
    for (var book in BOOK.values) {
      for (var chapter = 1; chapter <= bible.getChapterCount(book); chapter++) {
        print(book.toString() +" $chapter");
        expect((await bible.getChapter(book, chapter)).length > 1, true);
      }
    } 
  }); 

  test('Verse Check', () async {
    for (var book in BOOK.values) {
      expect((await bible.getVerses(book, 1, 1, 2)).length > 1, true);
    }
  });
}
