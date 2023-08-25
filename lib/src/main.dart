/// author: M2K Developments
/// github: https://github.com/m2kdevelopments


import 'dart:convert';
import 'package:flutter/services.dart';

/// An enum representing the books of the Bible.
enum BOOK {
  genesis,
  exodus,
  leviticus,
  numbers,
  deuteronomy,
  joshua,
  judges,
  ruth,
  firstSamuel,
  secondSamuel,
  firstKings,
  secondKings,
  firstChronicles,
  secondChronicles,
  ezra,
  nehemiah,
  esther,
  job,
  psalms,
  proverbs,
  ecclesiastes,
  songOfSolomon,
  isaiah,
  jeremiah,
  lamentations,
  ezekiel,
  daniel,
  hosea,
  joel,
  amos,
  obadiah,
  jonah,
  micah,
  nahum,
  habakkuk,
  zephaniah,
  haggai,
  zechariah,
  malachi,
  matthew,
  mark,
  luke,
  john,
  acts,
  romans,
  firstCorinthians,
  secondCorinthians,
  galatians,
  ephesians,
  philippians,
  colossians,
  firstThessalonians,
  secondThessalonians,
  firstTimothy,
  secondTimothy,
  titus,
  philemon,
  hebrews,
  james,
  firstPeter,
  secondPeter,
  firstJohn,
  secondJohn,
  thirdJohn,
  jude,
  revelation
}

/// A class representing a Bible with methods to access its content.
class Bible {
  List<dynamic> books = [];

  /// Initializes the Bible by loading book data from a JSON file.
  Future<void> init() async {
    final jsonContent =
        await rootBundle.loadString('packages/bible_chichewa/assets/content/books.json');
    var list = json.decode(jsonContent) as List<dynamic>;
    books.addAll(list);
  }

  /// Retrieves the verses of a specified chapter in a book.
  ///
  /// Returns a list of strings representing the verses of the requested chapter.
  ///
  /// - [book]: The enum representing the book of the Bible.
  /// - [chapter]: The chapter number.
  Future<List<String>> _getFile(int book, int chapter) async {
    var path = 'packages/bible_chichewa/assets/resources/$book/$chapter.json';
    final jsonContent = await rootBundle.loadString(path);
    var list = json.decode(jsonContent) as List<dynamic>;
    var verses = <String>[];
    for (var json in list) {
      verses.add(json as String);
    }
    return verses;
  }

  /// Retrieves a specific verse from a book, chapter, and verse index.
  ///
  /// - [book]: The enum representing the book of the Bible.
  /// - [chapter]: The chapter number.
  /// - [verse]: The verse number.
  Future<String> getVerse(BOOK book, int chapter, int verse) async {
    var verses = await _getFile(book.index + 1, chapter);
    return verses[verse + 1];
  }

  /// Retrieves a range of verses from a book, chapter, and verse range.
  ///
  /// Returns a list of strings representing the requested verses.
  ///
  /// - [book]: The enum representing the book of the Bible.
  /// - [chapter]: The chapter number.
  /// - [verseStart]: The starting verse number.
  /// - [verseEnd]: The ending verse number.
  Future<List<String>> getVerses(
      BOOK book, int chapter, int verseStart, int verseEnd) async {
    var verses = await _getFile(book.index + 1, chapter);
    return verses.sublist(verseStart - 1, verseEnd);
  }

  /// Retrieves all verses of a specific chapter in a book.
  ///
  /// Returns a list of strings representing all the verses of the chapter.
  ///
  /// - [book]: The enum representing the book of the Bible.
  /// - [chapter]: The chapter number.
  Future<List<String>> getChapter(BOOK book, int chapter) async {
    var verses = await _getFile(book.index + 1, chapter);
    return verses;
  }

  /// Returns the total number of chapters in a book.
  ///
  /// - [book]: The enum representing the book of the Bible.
  int getChapterCount(BOOK book) {
    return books[book.index]["chapters"] as int;
  }

  /// Retrieves the number of verses in a specific chapter of a book.
  ///
  /// - [book]: The enum representing the book of the Bible.
  /// - [chapter]: The chapter number.
  Future<int> getVerseCount(BOOK book, int chapter) async {
    var verses = await _getFile(book.index + 1, chapter);
    return verses.length;
  }

  /// Returns the names of all books in the Bible.
  List<String> getBooks() {
    return books.map((e) => e['name'] as String).toList();
  }

  /// Clears the book data from memory.
  void dispose() {
    books.clear();
  }
}