#!/bin/sh

for ARCH in `echo $ARCHS`; do
    RUST_ARCH="${ARCH}-apple-ios"
    if [ "${ARCH}" = "arm64" ]; then
        RUST_ARCH="aarch64-apple-ios"
    fi

    if [ "${CONFIGURATION}" = "release" ]; then
        CONFIG="--release"
    fi
    COMMAND="cargo $@ ${CONFIG} --target ${RUST_ARCH}"
    echo $COMMAND
    $COMMAND
done