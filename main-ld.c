#include "tls-ld.h"

int i = 8;
int j = -8;

int main() {
  set_vals(i, j);
  /* Should be zero */
  return sum();
}
