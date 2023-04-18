import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/anchor_types.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_testing/models/model.dart';
import 'package:ar_testing/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
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
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';

class ARPanorama extends StatefulWidget {
  const ARPanorama({Key? key}) : super(key: key);

  static const String routePath = '/AR-panorama';

  @override
  State<ARPanorama> createState() => _ObjectDetectionState();
}

class _ObjectDetectionState extends State<ARPanorama> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  late ARAnchorManager arAnchorManager;

  ARNode? node;

  @override
  void dispose() {
    super.dispose();
    arSessionManager.dispose();
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Stack(children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.none,
          ),
          Center(
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1750),
              child: Text(
                'Attendere il caricamento del panorama, potrebbe richiedere qualche secondo',
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
      floatingActionButton: Padding(
        padding: EdgeInsets.all(displayWidth * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: _goBack,
              child: const Icon(Icons.arrow_back),
            ),
          ],
        ),
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
          showPlanes: false,
          showWorldOrigin: false,
          handlePans: false,
          handleRotation: false,
          showAnimatedGuide: false,
        );
    this.arObjectManager.onInitialize();

    onScreenEntry();
    //this.arSessionManager.onPlaneOrPointTap = onPlaneOrPointTapped;
  }

  Future<void> onScreenEntry() async {
    final Model selectedPanorama =
        ModalRoute.of(context)!.settings.arguments as Model;
    var newNode = ARNode(
        type: NodeType.webGLB,
        uri: selectedPanorama.url,
        scale: selectedPanorama.scale,
        position: selectedPanorama.position);
    setState(() {
      _visible = !_visible;
    });
    bool? didAddWebNode = await this.arObjectManager.addNode(newNode);
    if (didAddWebNode != null) {
      node = newNode;
      setState(() {
        _visible = false;
      });
    } else {
      this.arSessionManager.onError('ERRORE');
    }
  }
}
