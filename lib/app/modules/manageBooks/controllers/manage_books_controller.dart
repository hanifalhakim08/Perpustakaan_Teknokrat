import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perpustakaan_teknokrat/app/controller/firebase_controller.dart';
import 'package:file_picker/file_picker.dart';

class ManageBooksController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference dbTeklib = FirebaseDatabase.instance.ref();

  final FBase = Get.put(FirestoreController());
  final cBookName = TextEditingController();
  final cAuthorName = TextEditingController();
  final cReleaseDate = TextEditingController();
  final cDesc = TextEditingController();
  final cGenre = TextEditingController();
  final cSinopsis = TextEditingController();
  var cImage = TextEditingController();
  var cPdf = TextEditingController(), cSearch = TextEditingController().obs;
  RxBool isPopular = false.obs;
  String bookId = "";
  String toUpdateGenre = "";
  RxBool isFav = false.obs;
  RxMap<String, String> pickedFile = <String, String>{}.obs;
  RxMap<String, String> pickedPdf = <String, String>{}.obs;
  var genre;
  var buku;
  Future FetchBooks() async {
    await dbTeklib.child("dbTeklib/books").once().then((value) {
      buku = value.snapshot.children;
    });
    await dbTeklib.child("dbTeklib/genres").once().then((value) {
      genre = value.snapshot.children;
    });
  }

  void clearController() {
    cBookName.clear();
    cAuthorName.clear();
    cReleaseDate.clear();
    cDesc.clear();
    cGenre.clear();
    bookId = "";
    toUpdateGenre = "";
    cSearch.value.clear();
    cSinopsis.clear();
    cImage.clear();
    cPdf.clear();
    pickedFile = <String, String>{}.obs;
    pickedPdf = <String, String>{}.obs;
    isPopular = false.obs;
  }

  String openDatePicker(context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1500),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        cReleaseDate.text = value.toString()!.substring(0, 10);
      } else {
        return "no date picked";
      }
    });
    return "succes";
  }

  Future<void> pickImage() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      pickedFile.addAll({
        'image_path': result.path,
        'image_name': result.name,
      });
      cImage.text = pickedFile['image_name'].toString();
    } else {
      print('No image picked');
    }
  }

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      pickedPdf.addAll({
        'pdf_path': result.files.single.path.toString(),
        'pdf_name': result.files.single.name.toString(),
      });
      cPdf.text = pickedPdf['pdf_name'].toString();
    } else {
      print('No file picked');
    }
  }

  RxBool isFinished = true.obs;
  Future addBook() async {
    if (pickedFile['image_path'] == null ||
        pickedFile['image_name'] == null ||
        cBookName.text.isEmpty ||
        cAuthorName.text.isEmpty ||
        cReleaseDate.text.isEmpty ||
        cDesc.text.isEmpty ||
        cSinopsis.text.isEmpty ||
        pickedPdf['pdf_path'] == null ||
        pickedPdf['pdf_name'] == null ||
        cGenre.text.isEmpty) {
      return Get.defaultDialog(
          title: "Error",
          middleText: "Please fill all the fields",
          onConfirm: () {
            Get.back();
          },
          textConfirm: "Ok",
          confirmTextColor: Colors.white,
          buttonColor: Colors.red);
    }
    try {
      isFinished.value = false;
      final imageRef =
          _storage.ref().child('images/${pickedFile['image_name']}');
      final pdfRef = _storage.ref().child('Books/${pickedPdf['pdf_name']}');

      final imageTask = await imageRef.putFile(
        File(pickedFile['image_path'].toString()),
        SettableMetadata(
          contentType: 'image/${pickedFile['image_name']!.split('.').last}',
        ),
      );
      final imageUrl = await imageTask.ref.getDownloadURL();
      pickedFile['image_path'] = imageUrl.toString();

      final pdfTask = await pdfRef.putFile(
        File(pickedPdf['pdf_path'].toString()),
        SettableMetadata(
          contentType: 'application/${pickedPdf['pdf_name']!.split('.').last}',
        ),
      );
      final pdfUrl = await pdfTask.ref.getDownloadURL();
      pickedPdf['pdf_path'] = pdfUrl.toString();

      dynamic books;
      final refWithbookId = dbTeklib.child('dbTeklib/books').push();
      await refWithbookId.set({
        'image_cover': pickedFile['image_path'].toString(),
        'book_name': cBookName.text,
        'author': cAuthorName.text,
        'desc': cDesc.text,
        'genre': cGenre.text,
        'sinopsis': cSinopsis.text,
        'release_date': cReleaseDate.text,
        'rating': 0,
        'borrow_counts': 0,
        'review_counts': 0,
        'like_counts': 0,
        'isPopular': isPopular.value,
        'pdf': pickedPdf['pdf_path'].toString(),
        'created_at': DateTime.now().toString(),
      }).then((value) {
        dbTeklib
            .child('dbTeklib/genres/${cGenre.text}')
            .once()
            .then((value) => {
                  if (value.snapshot.children.isNotEmpty)
                    {
                      if (value.snapshot.child('books').value != "null")
                        {
                          books = value.snapshot
                              .child('books')
                              .value
                              .toString()
                              .substring(
                                  1,
                                  value.snapshot
                                          .child('books')
                                          .value
                                          .toString()
                                          .length -
                                      1)
                              .split(',')
                              .map((book) => book.trim())
                              .toList(),
                          books.add(refWithbookId.key.toString()),
                        }
                      else
                        {
                          books = [refWithbookId.key.toString()]
                        },
                      dbTeklib.child('dbTeklib/genres/${cGenre.text}').update({
                        'books_counts': books.length,
                        'books': "${books}",
                      }),
                    }
                });
        isFinished.value = true;
      });

      return Get.defaultDialog(
        title: "success",
        middleText: "Book Added Successfully",
        onConfirm: () {
          clearController();
          Get.back();
        },
        textConfirm: "Ok",
        confirmTextColor: Colors.white,
        buttonColor: Colors.red,
      );
    } catch (e) {
      print(e);
    }
  }

  String flag = "";
  Future UpdateBook() async {
    if (dbTeklib.child('dbTeklib/books/$bookId').key != null) {
      try {
        if (pickedFile.isNotEmpty) {
          String? imageUrl = await _storage
              .ref()
              .child('images/${pickedFile['image_name']}')
              .putFile(
                  File(pickedFile['image_path'].toString()),
                  SettableMetadata(
                      contentType:
                          'image/${pickedFile['image_name']!.split('.').last}'))
              .snapshot
              .ref
              .getDownloadURL();
          cImage.text = imageUrl.isNotEmpty ? imageUrl : cImage.text;
        }
        if (pickedPdf.isNotEmpty) {
          String? pdfUrl = await _storage
              .ref()
              .child('Books/${pickedPdf['pdf_name']}')
              .putFile(
                  File(pickedPdf['pdf_path'].toString()),
                  SettableMetadata(
                      contentType:
                          'application/${pickedPdf['pdf_name']!.split('.').last}'))
              .snapshot
              .ref
              .getDownloadURL();
          pickedPdf['pdf_path'] = pdfUrl;
          cPdf.text = pdfUrl;
        } else {
          pickedPdf['pdf_path'] = flag;
        }
        dbTeklib
            .child('dbTeklib/books/$bookId')
            .update(Map.from({
              "image_cover": cImage.text,
              "pdf": pickedPdf['pdf_path'].toString(),
              "book_name": cBookName.text,
              "author": cAuthorName.text,
              "release_date": cReleaseDate.text,
              "desc": cDesc.text,
              "sinopsis": cSinopsis.text,
              "genre": cGenre.text,
              "isPopular": isPopular.value,
            }))
            .then((value) => {
                  cPdf.text = Uri.parse(cPdf.text.toString())
                      .pathSegments
                      .last
                      .split('/')
                      .last,
                });
        if (toUpdateGenre != cGenre.text) {
          var books = [];
          dbTeklib
              .child('dbTeklib/genres/${cGenre.text}')
              .once()
              .then((value) => {
                    if (value.snapshot.children.isNotEmpty)
                      {
                        if (value.snapshot.child('books').value != "null")
                          {
                            books = value.snapshot
                                .child('books')
                                .value
                                .toString()
                                .substring(
                                    1,
                                    value.snapshot
                                            .child('books')
                                            .value
                                            .toString()
                                            .length -
                                        1)
                                .split(',')
                                .map((book) => book.trim())
                                .toList(),
                            books.add(bookId.toString()),
                          }
                        else
                          {
                            books = [bookId.toString()]
                          },
                        dbTeklib
                            .child('dbTeklib/genres/${cGenre.text}')
                            .update({
                          'books_counts': books.length,
                          'books': "${books}",
                        }).then((value) => {
                                  books = [],
                                  dbTeklib
                                      .child('dbTeklib/genres/$toUpdateGenre')
                                      .once()
                                      .then((genre) => {
                                            books = genre.snapshot
                                                .child('books')
                                                .value
                                                .toString()
                                                .replaceAll('[', '')
                                                .replaceAll(" ", '')
                                                .replaceAll(']', '')
                                                .split(','),
                                            books.removeWhere((element) =>
                                                element == bookId.toString()),
                                            dbTeklib
                                                .child(
                                                    'dbTeklib/genres/$toUpdateGenre')
                                                .update({
                                              'books_counts': books.length,
                                              'books':
                                                  "${books.length == 0 ? null : books}"
                                            }),
                                          })
                                }),
                      }
                  });
        }
        return Get.defaultDialog(
          title: "success",
          middleText: "Book Updated Succesfully",
          onConfirm: () {
            Get.back();
          },
          textConfirm: "Ok",
          confirmTextColor: Colors.white,
          buttonColor: Colors.red,
        );
      } catch (e) {
        print(e);
      }
    }
    return "No book found";
  }

  void likeBook(
    String UID,
    String bookId,
  ) {
    dbTeklib
        .child('dbTeklib/books/$bookId/likes')
        .child(UID)
        .once()
        .then((value) {
      var Counts;
      if (value.snapshot.value != null) {
        dbTeklib.child('dbTeklib/books/$bookId/likes').child(UID).remove();
        dbTeklib
            .child('dbTeklib/books/$bookId/like_counts')
            .once()
            .then((counts) => {
                  Counts = counts.snapshot.value,
                  dbTeklib
                      .child('dbTeklib/books/$bookId/like_counts')
                      .set(Counts - 1),
                });
      } else {
        dbTeklib.child('dbTeklib/books/$bookId/likes/$UID').push().set({
          'created_at': DateTime.now().toString(),
        }).then((value) => {
              dbTeklib
                  .child('dbTeklib/books/$bookId/like_counts')
                  .once()
                  .then((counts) => {
                        Counts = counts.snapshot.value,
                        dbTeklib
                            .child('dbTeklib/books/$bookId/like_counts')
                            .set(Counts + 1),
                      }),
            });
      }
    });
  }

  void deleteBook(String bookId) {
    List Genre;
    dbTeklib.child('dbTeklib/books/' + bookId).once().then((value) => {
          dbTeklib
              .child('dbTeklib/genres/${value.snapshot.child('genre').value}')
              .once()
              .then((genre) => {
                    Genre = genre.snapshot
                        .child('books')
                        .value
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(" ", '')
                        .replaceAll(']', '')
                        .split(','),
                    Genre.removeWhere(
                        (element) => element == value.snapshot.key.toString()),
                    dbTeklib
                        .child(
                            'dbTeklib/genres/${value.snapshot.child('genre').value}')
                        .update({
                      'books_counts': Genre.length,
                      'books': "${Genre.length == 0 ? null : Genre}"
                    }),
                    dbTeklib.child('dbTeklib/books/' + bookId).remove()
                  })
        });
  }

  Future<String> addGenre() async {
    try {
      if (cGenre.text.isNotEmpty || cDesc.text.isNotEmpty) {
        await dbTeklib.child("dbTeklib/books").once().then((value) {
          var countSameGenre = 0;
          var books = [];
          value.snapshot.children.forEach((element) {
            if (element.child("genre").value == cGenre.text) {
              countSameGenre += 1;
              books.add(element.key);
            }
          });
          dbTeklib.child('dbTeklib/genres/${cGenre.text}').set({
            'books_counts': countSameGenre,
            'desc': cDesc.text,
            'created_at': DateTime.now().toString(),
            "books": "${books.length == 0 ? null : books}"
          });
        });
      }
      clearController();
      return "success";
    } catch (e) {
      return "failed";
    }
  }

  addBookFav(String uid) {
    List<String> fav; // Specify the type of elements in the list
    dbTeklib.child('dbTeklib/users/$uid/favorite_book/book_id').once().then((value) {
      fav = value.snapshot.value.toString()
          .replaceAll('[', '')
          .replaceAll(" ", '')
          .replaceAll(']', '')
          .split(',')
          .where((element) => element != "null" && element.isNotEmpty) // Add this line to remove empty elements
          .toList();
      print(fav);
      if (fav.contains(bookId)) {
        fav.remove(bookId);
        dbTeklib.child('dbTeklib/users/$uid/favorite_book').set({
          "book_id": "${fav}",
        });
        isFav.value = false;
        print("dihapus $fav");
      } else {
        fav.add(bookId);
        dbTeklib.child('dbTeklib/users/$uid/favorite_book').set({
          "book_id": "${fav}",
        });
        isFav.value = true;
        print("ditambah $fav");
      }
    });
  }

  void deleteGenre(String genre) {}

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
