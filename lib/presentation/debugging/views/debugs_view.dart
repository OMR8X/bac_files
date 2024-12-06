import 'package:bac_files_admin/core/services/debug/debugs_holder.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class DebugsView extends StatefulWidget {
  const DebugsView({super.key});

  @override
  State<DebugsView> createState() => _DebugsViewState();
}

class _DebugsViewState extends State<DebugsView> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Debugs [${DebugsHolder().debugs.length}]"),
          actions: [
            TextButton(
              onPressed: () {
                DebugsHolder().clearLogs();
                setState(() {});
              },
              child: const Text(
                "clear",
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: DebugsHolder().debugs.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
              )),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  DebugsHolder().debugs[index].message,
                  style: TextStyle(
                    fontSize: 12,
                    color: levelToColorMap[DebugsHolder().debugs[index].level],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

final Map<Level, Color> levelToColorMap = {
  Level.trace: Colors.grey,
  Level.debug: Colors.blue,
  Level.info: Colors.green,
  Level.warning: Colors.orange,
  Level.error: Colors.red,
  Level.fatal: Colors.purple,
  Level.off: Colors.transparent,
};