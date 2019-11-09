static int x;

void set_x(int val) {
  x = val;
}

int* get_x_addr() {
  return &x;
}

