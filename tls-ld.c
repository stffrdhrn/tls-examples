static __thread int x;
static __thread int y;

void set(int valx, int valy) {
  x = valx;
  y = valy;
}

int sum() {
  return x + y;
}
