class Videos {
  final String videoCategory, imagePath;
  int index;

  Videos({
    required this.videoCategory,
    required this.imagePath,
    required this.index,
  });
}

final allVideo = [
  Videos(
    videoCategory: "Abdominal",
    imagePath: "images/Abdominal.PNG",
    index: 0,
  ),
  Videos(
    videoCategory: "Arm",
    imagePath: "images/arm.jpg",
    index: 1,
  ),
  Videos(
    videoCategory: "Leg",
    imagePath: "images/leg.PNG",
    index: 2,
  ),
  Videos(
    videoCategory: "Back",
    imagePath: "images/back.png",
    index: 3,
  ),
  Videos(
    videoCategory: "Pectoral",
    imagePath: "images/chest.PNG",
    index: 4,
  ),
];
