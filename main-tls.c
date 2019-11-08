#include "tls.h"

__thread int i;
long a;

int main() {
   set_x(i);

   return get_x();
}

