int i = 4;

extern void set_x(int val);
extern int* get_x_addr();

int main() {
   set_x(i);
   /* Should be zero */
   return (*get_x_addr()) - 4;
}

