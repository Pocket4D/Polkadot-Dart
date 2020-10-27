// NOTE: Append the lines below to ios/Classes/<your>Plugin.h

void rust_cstr_free(char *s);

char *random_phrase(uint32_t words_number);

char *encrypt_data(const char *data, const char *password);

char *decrypt_data(const char *data, const char *password);

char *substrate_address(const char *suri, uint8_t prefix);

char *substrate_sign(const char *suri, const char *text);

bool schnorrkel_verify(const char *suri, const char *message, const char *signature);

int64_t decrypt_data_with_ref(const char *data, const char *password);

char *substrate_sign_with_ref(int64_t seed_ref, const char *suri_suffix, const char *text);

char *substrate_address_with_ref(int64_t seed_ref, const char *suri_suffix, uint8_t prefix);

void destroy_data_ref(int64_t data_ref);
