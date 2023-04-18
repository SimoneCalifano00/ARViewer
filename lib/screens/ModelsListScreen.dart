import 'package:ar_testing/ar_panorama.dart';
import 'package:ar_testing/widgets/model_item.dart';
import 'package:flutter/material.dart';
import '../dummy_3dmodels.dart';
import 'dart:io';

class ModelsListScreen extends StatelessWidget {
  ModelsListScreen({Key? key}) : super(key: key);
  static const String routePath = '/3dModels-List';
  final modelList =
      DUMMY_3DMODELS.where((model) => model.isPanorama == false).toList();
  @override
  Widget build(BuildContext context) {
    final _displayHeight = MediaQuery.of(context).size.height;
    final _displayWidth = MediaQuery.of(context).size.width;
    final _displayPaddingBottom = MediaQuery.of(context).padding.bottom;
    final _displayPaddingTop = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        height: (_displayHeight - _displayPaddingBottom - _displayPaddingTop),
        width: _displayWidth,
        child: Column(
          children: [
            SizedBox(
              height: (_displayHeight) * 0.05,
            ),
            Padding(
              padding: EdgeInsets.all(_displayHeight * 0.01),
              child: Text(
                'Tocca uno degli elementi per visualizzare il modello in AR!',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: (_displayHeight) * 0.01,
            ),
            Flexible(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ModelItem(modelList[index]);
                },
                itemCount: modelList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
