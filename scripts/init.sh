#!/bin/bash

source ./scripts/variables.sh

echo "${OS_ARCH}-archs"

for i in "${ANDROID_ARCHS[@]}";
  do rustup target add "$i" ;
done

for i in "${IOS_ARCHS[@]}";
  do rustup target add "$i";
done

#cargo install cargo-lipo
#cargo install cbindgen

#ln -s ./litentry_rust/rust/target/aarch64-linux-android/release/libexample.so ./litentry_app/android/src/main/arm64-v8a/
#ln -s ./litentry_rust/rust/target/armv7-linux-androideabi/release/libexample.so ./litentry_app/android/src/main/armeabi-v7a/
#ln -s ./litentry_rust/rust/target/i686-linux-android/release/libexample.so ./litentry_app/android/src/main/x86/
#
#ln -s ./litentry_rust/rust/target/universal/release/libexample.a ./litentry_app/ios/




