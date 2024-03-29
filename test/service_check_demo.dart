import 'package:flutter/material.dart';
import 'package:latext/latext.dart';
import 'package:mathgptpro_mclient_flutter/utils/dio_utils.dart';

void main() {
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Chat UI Demo',
      home: StreamView(),
    );
  }
}

class StreamView extends StatefulWidget {
  const StreamView({Key? key}) : super(key: key);

  @override
  State<StreamView> createState() => _StreamViewState();
}

class _StreamViewState extends State<StreamView> {
  final DioUtils _dioUtils = DioUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            const LaTexT(
              laTeXCode: Text(""),
              breakDelimiter: '\n',
            ),
            Container(
              height: 20,
            ),
          ],
        ));
  }
}
