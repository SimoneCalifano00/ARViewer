import 'package:ar_testing/ar_panorama.dart';
import 'package:ar_testing/localobjectdisplay.dart';
import 'package:ar_testing/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ModelItem extends StatelessWidget {
  final Model model;

  const ModelItem(this.model);

  void selectModel(BuildContext context) {
    if (!model.isPanorama) {
      Navigator.of(context)
          .pushNamed(LocalObjectWidget.routePath, arguments: model);
    } else
      Navigator.of(context).pushNamed(ARPanorama.routePath, arguments: model);
  }

  @override
  Widget build(BuildContext context) {
    final _displayHeight = MediaQuery.of(context).size.height;
    final _displayWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => selectModel(context),
      enableFeedback: true,
      splashColor: Colors.amber,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_displayWidth * 0.1)),
        elevation: 15,
        shadowColor: Theme.of(context).shadowColor,
        margin: EdgeInsets.all(_displayWidth * 0.07),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(_displayWidth * 0.2),
                  ),
                  child: Image.asset(
                    model.previewImgUri,
                    height: _displayHeight * 0.27,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(_displayWidth * 0.05),
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(children: [
                    const Icon(
                      Icons.image_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: _displayWidth * 0.01,
                    ),
                    Text(model.name,
                        style: Theme.of(context).textTheme.bodyText2,
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor),
                  ]),
                  SizedBox(
                    width: _displayWidth * 0.1,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.photo_size_select_large_outlined,
                          color: Colors.black),
                      SizedBox(
                        width: _displayWidth * 0.01,
                      ),
                      Text(
                        model.spazioRichiestoText,
                        style: Theme.of(context).textTheme.bodyText2,
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
