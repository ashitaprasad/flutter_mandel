import 'dart:ui';
import 'dart:math' as math;

class Mandelbrot {
  static const int maxIterations = 2000;

  int iterations(double x0, double y0) {
    if (y0 < 0) {
      y0 = -y0;
    }
    double x = x0;
    double y = y0;
    double xT;

    for (int i = 0; i < maxIterations; i++) {
      if (x * x + y * y > 4) {
        return i;
      }

      xT = x * x - y * y + x0;
      y = 2 * x * y + y0;
      x = xT;
    }
    return maxIterations;
  }

  static int colorFromIteration(int iter) {
    int color = 0x4400ffff;
    if (iter > 0) {
      color = Color.fromRGBO(
        255 * (1 + math.cos(3.32 * math.log(iter + 1))) ~/ 1,
        255 * (1 + math.cos(.774 * math.log(iter + 1))) ~/ 1,
        255 * (1 + math.cos(.412 * math.log(iter + 1))) ~/ 1,
        1,
      ).toARGB32();
    }
    return color;
  }

  renderData({
    required List<int> data,
    required double xMin,
    required double xMax,
    required double yMin,
    required double yMax,
    required int bitmapWidth,
    required int bitMapHeight,
  }) async {
    // Per-pixel step values
    double dx = (xMax - xMin) / bitmapWidth;
    double dy = (yMax - yMin) / bitMapHeight;

    double y = yMin + dy / 2;
    int ib = 0;
    for (int iy = 0; iy < bitMapHeight; iy++) {
      double x = xMin + dx / 2;
      for (int ix = 0; ix < bitmapWidth; ix++) {
        int iters = iterations(x, y);
        data[ib++] = colorFromIteration(iters);
        x += dx;
      }
      y += dy;
    }
  }
}
