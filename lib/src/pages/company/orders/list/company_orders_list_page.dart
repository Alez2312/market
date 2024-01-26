import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:market/src/pages/company/orders/list/company_orders_list_controllers.dart';
import 'package:market/src/utils/main_colors.dart';

class CompanyOrdersListPage extends StatefulWidget {
  const CompanyOrdersListPage({super.key});

  @override
  State<CompanyOrdersListPage> createState() => _CompanyOrdersListPageState();
}

class _CompanyOrdersListPageState extends State<CompanyOrdersListPage> {
  final CompanyOrdersListController _controller = CompanyOrdersListController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.key,
      drawer: _drawer(),
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      body: const Center(
        child: Text('CompanyOrdersList Page'),
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _controller.openDrawer,
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png', width: 20, height: 20),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: MyColors.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_controller.user?.name ?? ''} ${_controller.user?.lastname ?? ''}',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                Text(
                  _controller.user?.email ?? '',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  maxLines: 1,
                ),
                Text(
                  _controller.user?.phone ?? '',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  maxLines: 1,
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(top: 10),
                  child: FadeInImage(
                    image: _controller.user?.image != null
                        ? NetworkImage(_controller.user!.image!)
                        : const AssetImage('assets/img/no-image.png')
                            as ImageProvider,
                    fit: BoxFit.contain,
                    fadeInDuration: const Duration(milliseconds: 50),
                    placeholder: const AssetImage('assets/img/no-image.png'),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: const Text("Crear Categoría"),
            trailing: const Icon(Icons.list_alt),
            onTap: () => _controller.goToCategoryCreate(),
          ),
          _controller.user != null
              ? _controller.user!.roles!.length > 1
                  ? ListTile(
                      onTap: _controller.goToRoles,
                      title: const Text("Seleccionar Rol"),
                      trailing: const Icon(Icons.person_outline),
                    )
                  : Container()
              : Container(),
          ListTile(
            title: const Text("Cerrar Sesión"),
            trailing: const Icon(Icons.power_settings_new),
            onTap: () => _controller.logout(),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
