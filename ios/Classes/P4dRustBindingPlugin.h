#import <Flutter/Flutter.h>

@interface P4dRustBindingPlugin : NSObject<FlutterPlugin>
@end
// NOTE: Append the lines below to ios/Classes/<your>Plugin.h

void rust_cstr_free(char *s);

char *bip39_generate(uint32_t words_number);

bool bip39_validate(const char *phrase);

char *bip39_to_entropy(const char *phrase);

char *bip39_to_mini_secret(const char *phrase, const char *password);

char *bip39_to_seed(const char *phrase, const char *password);

char *blake2b(const char *data, const char *key, uint32_t size);

char *keccak256(const char *data);

char *pbkdf2(const char *data, const char *salt, uint32_t rounds);

char *scrypt(const char *password, const char *salt, uint8_t log2_n, uint32_t r, uint32_t p);

char *sha512(const char *data);

char *twox(const char *data, uint32_t rounds);

char *encrypt_data(const char *data, const char *password);

char *decrypt_data(const char *data, const char *password);

char *substrate_address(const char *suri, uint8_t prefix);

char *substrate_sign(const char *suri, const char *text);

bool schnorrkel_verify(const char *suri, const char *message, const char *signature);

int64_t decrypt_data_with_ref(const char *data, const char *password);

char *substrate_sign_with_ref(int64_t seed_ref, const char *suri_suffix, const char *text);

char *substrate_address_with_ref(int64_t seed_ref, const char *suri_suffix, uint8_t prefix);

void destroy_data_ref(int64_t data_ref);
