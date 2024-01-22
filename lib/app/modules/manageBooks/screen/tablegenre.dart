// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controller/auth_controller.dart';
// import '../controllers/manage_books_controller.dart';

// class tableGenre extends StatefulWidget {
//   const tableGenre({super.key});

//   @override
//   State<tableGenre> createState() => _tableGenreState();
// }

// class _tableGenreState extends State<tableGenre> {
//   final cManageBooks = Get.put(ManageBooksController());
//   final cAuth = Get.put(AuthController());
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: StreamBuilder(
//         stream: cManageBooks.dbTeklib.child("dbTeklib/genres").onValue,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             var genres = snapshot.data!.snapshot;
//             return ListView(
//               padding: EdgeInsets.all(0),
//               children: [
//                 for (var genre in genres.children)
//                   ListTile(
//                     titleAlignment: ListTileTitleAlignment.center,
//                     title: Text(
//                       '${genre.key.toString().replaceAll("_", " ")}',
//                     ),
//                     subtitle: Text(
//                         "Books Counts : ${genre.child('books_counts').value.toString()}"),
//                     trailing: InkWell(
//                       onTap: () {
//                         Get.to(() => viewDetails(), arguments: genre);
//                       },
//                       child: Text("View"),
//                     ),
//                   ),
//               ],
//             );
//           }
//           return Text("Loading");
//         },
//       ),
//     );
//   }
// }
