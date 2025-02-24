double getClosestMultipleDistance(double target, double multiple) {
  var closestMultiple = getClosestMultiple(target, multiple);
  return (closestMultiple - target).abs();
}

double getClosestMultiple(double target, double multiple) {
   return (target / multiple).round() * multiple;
}
