import 'package:flutter/material.dart';
import 'package:flutter_mandel/render_manager.dart';
import 'mandel_explorer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CPU Profiler Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const IsolateControl(),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MandelExplorer(),
                    ),
                  );
                },
                child: const Text("Launch Explorer")),
          ],
        ),
      ),
    );
  }
}

class IsolateControl extends StatefulWidget {
  const IsolateControl({
    Key? key,
  }) : super(key: key);

  @override
  State<IsolateControl> createState() => _IsolateControlState();
}

class _IsolateControlState extends State<IsolateControl> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('# of rendering Isolates: ${renderManager.isolateList.length}'),
        const SizedBox(
          width: 16,
        ),
        IconButton(
            onPressed: () async {
              await renderManager.increaseIsolateCount();
              setState(() {});
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () => setState((renderManager.decreaseIsolateCount)),
            icon: const Icon(Icons.remove))
      ],
    );
  }
}
