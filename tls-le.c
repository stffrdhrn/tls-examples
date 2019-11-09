static __thread int x;

void set_x(int valx) {
  x = valx;
}

int* get_x_addr() {
  return &x;
}
