enum ServingSize { Small, Medium, Large, Avengers }

var _model2Dto = {
  1: ServingSize.Small,
  2: ServingSize.Medium,
  3: ServingSize.Large,
  4: ServingSize.Avengers,
};

ServingSize parseServingSize(int size) {
  return _model2Dto[size];
}

int fromServingSize(ServingSize size) {
  return _model2Dto.keys.firstWhere((key) => _model2Dto[key] == size);
}