import 'package:flutter/material.dart';
import 'package:market/src/pages/client/products/list/client_products_list_page.dart';
import 'package:market/src/pages/client/update/client_update_page.dart';
import 'package:market/src/pages/company/categories/create/company_categories_create_page.dart';
import 'package:market/src/pages/company/orders/list/company_orders_list_page.dart';
import 'package:market/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:market/src/pages/login/login_page.dart';
import 'package:market/src/pages/register/register_page.dart';
import 'package:market/src/pages/roles/roles_page.dart';
import 'package:market/src/utils/main_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: MyColors.primaryColor),
      title: "Market",
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => const LoginPage(),
        'register': (BuildContext context) => const RegisterPage(),
        'roles': (BuildContext context) => const RolesPage(),
        'client/products/list': (BuildContext context) =>
            const ClientProductsListPage(),
        'client/update': (BuildContext context) => const ClientUpdatePage(),
        'company/orders/list': (BuildContext context) =>
            const CompanyOrdersListPage(),
        'company/categories/create/page': (BuildContext context) =>
            const CompanyCategoriesCreatePage(),
        'delivery/orders/list': (BuildContext context) =>
            const DeliveryOrdersListPage(),
      },
    );
  }
}
