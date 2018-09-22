#!/bin/sh

# Iterate through the list of ARCHS and build each one
for ARCH in `echo $ARCHS`; do
    RUST_ARCH="${ARCH}-apple-ios"
    # iOS and rust differ on the name of this ARCH
    if [ "${ARCH}" = "arm64" ]; then
        RUST_ARCH="aarch64-apple-ios"
    fi

    # build in release mode if the configuration requests it
    if [ "${CONFIGURATION}" = "release" ]; then
        CONFIG="--release"
    fi
    COMMAND="cargo $@ ${CONFIG} --target ${RUST_ARCH}"
    echo $COMMAND
    $COMMAND
done