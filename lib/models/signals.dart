class Signal {
  int id;
  String descriptionMalayalam;
  String descriptionEnglish;
  String image;
  int classification;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Signal && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'description_mall': this.descriptionMalayalam,
      'description_eng': this.descriptionEnglish,
      'image': this.image,
      'classification': this.classification
    };
  }

  static Signal fromJson(Map<String, dynamic> model) {
    Signal signal = Signal();
    signal.id = model['id'];
    signal.descriptionMalayalam = model['description_mal'];
    signal.descriptionEnglish = model['description_eng'];
    signal.image = model['image'];
    signal.classification = model['classification'];
    return signal;
  }
}
