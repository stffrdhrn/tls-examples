static __thread int x;

void set(int valx) {
  x = valx;
}

int* get_x_addr() {
  return &x;
}
