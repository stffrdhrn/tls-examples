static int x;

void set(int val) {
  x = val;
}

int* get_x_addr() {
  return &x;
}
