class Animal{
  String? animalName;
  String? kind;
  String? imagePath;
  bool? flyExist;
  Animal({
    required this.animalName,
    required this.kind,
    required this.imagePath,
    this.flyExist
  });
}