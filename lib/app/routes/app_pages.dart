import 'package:get/get.dart';

import '../modules/addbook/bindings/addbook_binding.dart';
import '../modules/addbook/views/addbook_view.dart';
import '../modules/books/bindings/books_binding.dart';
import '../modules/books/views/books_view.dart';
import '../modules/bookshelf/bindings/bookshelf_binding.dart';
import '../modules/bookshelf/views/bookshelf_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/manageBooks/bindings/manage_books_binding.dart';
import '../modules/manageBooks/views/manage_books_view.dart';
import '../modules/manageusers/bindings/manageusers_binding.dart';
import '../modules/manageusers/views/manageusers_view.dart';
import '../modules/paneladmin/bindings/paneladmin_binding.dart';
import '../modules/paneladmin/views/paneladmin_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/readBook/bindings/read_book_binding.dart';
import '../modules/readBook/views/read_book_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/resetpassword/bindings/resetpassword_binding.dart';
import '../modules/resetpassword/views/resetpassword_view.dart';
import '../modules/searchbook/bindings/searchbook_binding.dart';
import '../modules/searchbook/views/searchbook_view.dart';
import '../modules/viewbook/bindings/viewbook_binding.dart';
import '../modules/viewbook/views/viewbook_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      parameters: {'page': 'Home'},
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.RESETPASSWORD,
      page: () => const ResetpasswordView(),
      binding: ResetpasswordBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.BOOKSHELF,
      page: () => const BookshelfView(),
      binding: BookshelfBinding(),
    ),
    GetPage(
      name: _Paths.ADDBOOK,
      page: () => const AddbookView(),
      binding: AddbookBinding(),
    ),
    GetPage(
      name: _Paths.PANELADMIN,
      page: () => const PaneladminView(),
      binding: PaneladminBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_BOOKS,
      page: () => const ManageBooksView(),
      binding: ManageBooksBinding(),
    ),
    GetPage(
      name: _Paths.VIEWBOOK,
      page: () => const ViewbookView(),
      binding: ViewbookBinding(),
    ),
    GetPage(
      name: _Paths.READ_BOOK,
      page: () => const ReadBookView(),
      binding: ReadBookBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHBOOK,
      page: () => const SearchbookView(),
      binding: SearchbookBinding(),
    ),
    GetPage(
      name: _Paths.BOOKS,
      page: () => const BooksView(),
      binding: BooksBinding(),
    ),
    GetPage(
      name: _Paths.MANAGEUSERS,
      page: () => const ManageusersView(),
      binding: ManageusersBinding(),
    ),
  ];
}
