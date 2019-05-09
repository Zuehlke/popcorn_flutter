enum Flavour { Salty, Sweet, Caramel, Wasabi }

var _model2Dto = {
  "SALTY": Flavour.Salty,
  "SWEET": Flavour.Sweet,
  "CARAMEL": Flavour.Caramel,
  "WASABI": Flavour.Wasabi,
};

Flavour parseFlavour(String flavour) {
  return _model2Dto[flavour];
}

String fromFlavour(Flavour flavour) {
  return _model2Dto.keys.firstWhere((key) => _model2Dto[key] == flavour);
}

List<Flavour> parseFlavours(List<dynamic> flavours) {
  if (flavours == null) {
    return new List<Flavour>();
  }

  return flavours.map((value) => parseFlavour(value)).toList();
}
