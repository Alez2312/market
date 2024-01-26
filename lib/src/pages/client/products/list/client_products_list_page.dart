import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:market/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:market/src/utils/main_colors.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({super.key});

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  final ClientProductsListController _controller =
      ClientProductsListController();

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
      body: Center(
          child: ElevatedButton(
        onPressed: _controller.logout,
        child: const Text('Cerrar Sesión'),
      )),
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
            onTap: _controller.goToUpdatePage,
            title: const Text("Editar Perfil"),
            trailing: const Icon(Icons.edit_outlined),
          ),
          const ListTile(
            title: Text("Mis Pedidos"),
            trailing: Icon(Icons.shopping_cart_outlined),
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
