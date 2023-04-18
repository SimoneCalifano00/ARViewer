import 'package:ar_testing/models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart';

final DUMMY_3DMODELS = [
  Model(
    name: 'Papera Gialla',
    url:
        'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb',
    previewImgUri: 'lib/assets/img/duck.png',
    scale: Vector3(0.2, 0.2, 0.2),
    position: Vector3(0.0, 0.0, 0.0),
    spazio: SpazioRichiesto.Poco,
    description:
        'Simpatica paperella gialla che simula le proprietà della plastica',
    tipo: Type.modello3d,
  ),
  Model(
    name: "Sedia d'ufficio",
    url:
        'https://github.com/SimoneCalifano00/3DModels/raw/main/office-chair.glb',
    previewImgUri: 'lib/assets/img/office-chair.png',
    scale: Vector3(0.9, 0.9, 0.9),
    position: Vector3(0.0, 0.0, 0.0),
    spazio: SpazioRichiesto.Medio,
    description: "Classica sedia d'ufficio ergonomica ed in pelle",
    tipo: Type.modello3d,
  ),
  Model(
    name: "Ercole Farnese",
    url:
        "https://github.com/SimoneCalifano00/3DModels/raw/main/ercole-nonorm.glb",
    previewImgUri: 'lib/assets/img/ercole-farnese.png',
    scale: Vector3(1, 1, 1),
    position: Vector3(0.0, 0.0, 0.0),
    spazio: SpazioRichiesto.Tanto,
    description:
        "L'Ercole Farnese è una celebre scultura ellenistica in marmo alta 317 cm di Glicone di Atene " +
            "databile al III secolo d.C.",
    tipo: Type.modello3d,
  ),
  Model(
    name: "Bottiglia d'acqua",
    url:
        'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/WaterBottle/glTF-Binary/WaterBottle.glb',
    previewImgUri: 'lib/assets/img/water-bottle.png',
    scale: Vector3(0.5, 0.7, 0.4),
    position: Vector3(0.0, 0.0, 0.0),
    spazio: SpazioRichiesto.Poco,
    description: "Borraccia composta di un materiale riflettente",
    tipo: Type.modello3d,
  ),
  Model(
    name: "Sofa",
    url: "https://github.com/SimoneCalifano00/3DModels/raw/main/sofa.glb",
    previewImgUri: 'lib/assets/img/sofa.png',
    scale: Vector3(1, 1, 1),
    position: Vector3(0.0, 0.0, 0.0),
    spazio: SpazioRichiesto.Medio,
    description: "Sofa",
    tipo: Type.modello3d,
  ),
  Model(
      name: "Modellino Auto",
      url:
          "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/ToyCar/glTF-Binary/ToyCar.glb",
      previewImgUri: 'lib/assets/img/car.jpg',
      scale: Vector3(20, 20, 20),
      position: Vector3(0.0, 0.0, 0.0),
      spazio: SpazioRichiesto.Tanto,
      description:
          "Modellino d'auto presentato su una base che simula un tessuto, il modellino ha una carrozzeria riflettente e presenta parti trasparenti",
      tipo: Type.modello3d),
  Model(
    name: "Scarpe blu",
    url:
        "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/MaterialsVariantsShoe/glTF-Binary/MaterialsVariantsShoe.glb",
    previewImgUri: 'lib/assets/img/shoe.png',
    scale: Vector3(0.6, 0.6, 0.6),
    position: Vector3(0.0, 0.0, 0.0),
    spazio: SpazioRichiesto.Poco,
    description:
        "Scarpa da ginnastica che presenta un modello 3d con una mesh estremamente curata e texture dotate di profondità",
    tipo: Type.modello3d,
  ),
  Model(
      name: "Panorama di costa",
      url:
          "https://github.com/SimoneCalifano00/3DModels/raw/main/sphere-panorama-glossy.glb",
      scale: Vector3(8, 7, 7),
      previewImgUri: "lib/assets/img/sphere-panorama.png",
      position: Vector3(0, -3, 0),
      spazio: SpazioRichiesto.Poco,
      description: "Panorama sferico di costa",
      tipo: Type.panoramaAR),
];
