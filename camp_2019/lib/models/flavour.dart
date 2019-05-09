enum Flavour { Salty, Sweet, Caramel, Wasabi }

Flavour parseFlavour(String flavour) {
  switch (flavour) {
    case 'SALTY':
      return Flavour.Salty;
    case 'SWEET':
      return Flavour.Sweet;
    case 'CARAMEL':
      return Flavour.Caramel;
    case 'WASABI':
      return Flavour.Wasabi;
  }

  throw flavour;
}

List<Flavour> parseFlavours(List<dynamic> flavours) {
  if (flavours == null) {
    return new List<Flavour>();
  }

  return flavours.map((value) => parseFlavour(value)).toList();
}
