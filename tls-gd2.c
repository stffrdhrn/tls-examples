extern __thread char tls_var;
extern __thread char tls_var2;

char get_tls_var() {
  return tls_var + tls_var2;
}
