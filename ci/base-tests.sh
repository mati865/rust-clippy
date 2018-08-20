set -ex

echo "Running clippy base tests"

PATH=$PATH:./node_modules/.bin
remark -f *.md > /dev/null
# build clippy in debug mode and run tests
cargo build --features debugging
cargo test --features debugging
mkdir -p ~/rust/cargo/bin
cp target/debug/cargo-clippy ~/rust/cargo/bin/cargo-clippy
cp target/debug/clippy-driver ~/rust/cargo/bin/clippy-driver
rm ~/.cargo/bin/cargo-clippy
cargo install --force --path .
# run clippy on its own codebase...
cargo clippy --all-targets --all-features -- -D clippy
# ... and some test directories
cd clippy_workspace_tests && cargo clippy -- -D clippy && cd ..
cd clippy_workspace_tests/src && cargo clippy -- -D clippy && cd ../..
cd clippy_workspace_tests/subcrate && cargo clippy -- -D clippy && cd ../..
cd clippy_workspace_tests/subcrate/src && cargo clippy -- -D clippy && cd ../../..
# test --manifest-path
cargo clippy --manifest-path=clippy_workspace_tests/Cargo.toml -- -D clippy
cd clippy_workspace_tests/subcrate && cargo clippy --manifest-path=../Cargo.toml -- -D clippy && cd ../..
set +x
