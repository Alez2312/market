import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:market/src/models/rol.dart';
import 'package:market/src/pages/roles/roles_controller.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  final RolesController _controller = RolesController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona un Rol'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
        child: ListView(
            children: _controller.user != null
                ? _controller.user!.roles!.map((Rol rol) {
                    return _cardRol(rol);
                  }).toList()
                : []),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    ImageProvider imageProvider;
    if (rol.image != null) {
      imageProvider = NetworkImage(rol.image!);
    } else {
      imageProvider = const AssetImage('assets/img/no-image.png');
    }

    return GestureDetector(
      onTap: () {
        _controller.goToPage(rol.route);
      },
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: FadeInImage(
              image: imageProvider,
              fit: BoxFit.contain,
              fadeInDuration: const Duration(milliseconds: 50),
              placeholder: const AssetImage('assets/img/no-image.png'),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            rol.name ?? "",
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
