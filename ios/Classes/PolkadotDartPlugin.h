#import <Flutter/Flutter.h>

@interface PolkadotDartPlugin : NSObject<FlutterPlugin>
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

char *xxhash64(const char *data, uint32_t seed);

char *bip32_get_private_key(const char *seed, const char *path);

char *ed25519_get_pub_from_prv(const char *private_key);

char *secp256k1_get_pub_from_prv(const char *private_key);

char *secp256k1_get_compress_pub(const char *uncompressed);

char *secp256k1_recover(const char *message, const char *signature, uint8_t recovery_id);

char *sr25519_get_pub_from_seed(const char *seed);

char *ed25519_keypair_from_seed(const char *seed);

char *ed25519_sign(const char *pubkey, const char *seckey, const char *message);

bool ed25519_verify(const char *signature, const char *message, const char *pubkey);

char *sr25519_derive_keypair_hard(const char *pair, const char *cc);

char *sr25519_derive_keypair_soft(const char *pair, const char *cc);

char *sr25519_derive_public_soft(const char *pubkey, const char *cc);

char *sr25519_keypair_from_seed(const char *seed);

char *sr25519_keypair_from_pair(const char *pair);

char *sr25519_sign(const char *pubkey, const char *seckey, const char *message);

bool sr25519_verify(const char *signature, const char *message, const char *pubkey);
