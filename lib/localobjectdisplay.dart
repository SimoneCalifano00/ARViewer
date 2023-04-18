import 'dart:ffi';

import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_testing/dummy_3dmodels.dart';
import 'package:ar_testing/screens/ModelsListScreen.dart';
import 'package:ar_testing/screens/tabs_screen.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'models/model.dart';

class LocalObjectWidget extends StatefulWidget {
  const LocalObjectWidget({Key? key}) : super(key: key);

  static const String routePath = '/AR-viewer';

  @override
  State<LocalObjectWidget> createState() => _LocalObjectWidgetState();
}

class _LocalObjectWidgetState extends State<LocalObjectWidget> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  late ARAnchorManager arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  @override
  void dispose() {
    super.dispose();
    arSessionManager.dispose();
  }

  void _goBack() {
    Navigator.pop(context);
  }

  var _visible = false;

  @override
  Widget build(BuildContext context) {
    final _displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Stack(children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Center(
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1500),
              child: Text(
                'Attendere il caricamento del modello',
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
                style: TextStyle(
                    backgroundColor: Color.fromARGB(148, 35, 34, 34),
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'Raleway'),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: (_displayWidth * 0.07)),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: _goBack,
              child: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          const SizedBox(
            width: 100,
          ),
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 236, 43, 21),
            onPressed: onRemoveEverything,
            child: const Icon(
              Icons.delete_outline,
            ),
          ),
        ],
      ),
    );
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          showWorldOrigin: false,
          handlePans: true,
          handleRotation: true,
          showAnimatedGuide: false,
        );
    this.arObjectManager.onInitialize();

    this.arSessionManager.onPlaneOrPointTap = onPlaneOrPointTapped;
  }

  Future<void> onRemoveEverything() async {
    anchors.forEach((anchor) {
      this.arAnchorManager.removeAnchor(anchor);
    });
    anchors = [];
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult?> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult!.type == ARHitTestResultType.plane);
    if (singleHitTestResult != null) {
      var newAnchor =
          ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor = await this.arAnchorManager.addAnchor(newAnchor);
      if (didAddAnchor != null) {
        setState(() {
          _visible = !_visible;
        });
        this.anchors.add(newAnchor);
        var newNode = onScreenEntry();
        bool? didAddNodeToAnchor =
            await this.arObjectManager.addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor != null) {
          this.nodes.add(newNode);
          setState(() {
            _visible = false;
          });
        } else {
          this.arSessionManager.onError("Aggiunta del nodo all'Anchor fallito");
        }
      } else {
        this.arSessionManager.onError("Aggiunta dell'Anchor fallita");
      }
    }
  }

  ARNode onScreenEntry() {
    final Model selectedModel =
        ModalRoute.of(context)!.settings.arguments as Model;
    var newNode = ARNode(
      type: NodeType.webGLB,
      uri: selectedModel.url,
      scale: selectedModel.scale,
      position: Vector3(0.0, 0.0, 0.0),
      rotation: Vector4(1.0, 0.0, 0.0, 0.0),
    );
    return newNode;
  }

  onPanStarted(String nodeName) {
    print("Started panning node " + nodeName);
  }

  onPanChanged(String nodeName) {
    print("Continued panning node " + nodeName);
  }

  onPanEnded(String nodeName, Matrix4 newTransform) {
    print("Ended panning node " + nodeName);
    final pannedNode =
        this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //pannedNode.transform = newTransform;
  }

  onRotationStarted(String nodeName) {
    print("Started rotating node " + nodeName);
  }

  onRotationChanged(String nodeName) {
    print("Continued rotating node " + nodeName);
  }

  onRotationEnded(String nodeName, Matrix4 newTransform) {
    print("Ended rotating node " + nodeName);
    final rotatedNode =
        this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //rotatedNode.transform = newTransform;
  }
}
