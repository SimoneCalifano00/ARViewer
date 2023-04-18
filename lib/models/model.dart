import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

enum Type {
  modello3d,
  panoramaAR,
}

enum SpazioRichiesto {
  Poco,
  Medio,
  Tanto,
}

class Model {
  //nome dell'oggetto 3d
  final String name;
  final String url;
  final String previewImgUri;
  final Vector3 scale;
  final Vector3 position;
  final String description;
  final SpazioRichiesto spazio;
  final Type tipo;

  const Model({
    required this.name,
    required this.url,
    required this.previewImgUri,
    required this.scale,
    required this.position,
    required this.description,
    required this.spazio,
    required this.tipo,
  });

  String get spazioRichiestoText {
    switch (spazio) {
      case SpazioRichiesto.Poco:
        return 'Poco spazio';
        break;
      case SpazioRichiesto.Medio:
        return "Un po' di spazio";
        break;
      case SpazioRichiesto.Tanto:
        return 'Tanto spazio';
        break;
    }
  }

  bool get isPanorama {
    switch (tipo) {
      case Type.panoramaAR:
        return true;
      case Type.modello3d:
        return false;
    }
  }
}
