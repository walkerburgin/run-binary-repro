# run-binary-repro

## Repro one

Run `bazel build -s :repro_one`:

```console
➜  run-binary-repro git:(master) ✗ bazel build -s :repro_one
INFO: Analyzed target //:repro_one (0 packages loaded, 0 targets configured).
SUBCOMMAND: # //:repro_one [action 'RunBinary repro_one.txt', configuration: 096dcc84165363e69a851ebe8131b032f5448c94ddc4951775429dc78e79f898, execution platform: @@platforms//host:host, mnemonic: RunBinary]
(cd /private/var/tmp/_bazel_wburgin/cb3bef35f39127f502d8d180ce497830/execroot/_main && \
  exec env - \
  bazel-out/darwin_arm64-opt-exec-ST-d57f47055a04/bin/debug_args --output-file bazel-out/darwin_arm64-fastbuild/bin/repro_one.txt value with spaces)
# Configuration: 096dcc84165363e69a851ebe8131b032f5448c94ddc4951775429dc78e79f898
# Execution platform: @@platforms//host:host
INFO: Found 1 target...
Target //:repro_one up-to-date:
  bazel-bin/repro_one.txt
INFO: Elapsed time: 0.141s, Critical Path: 0.03s
INFO: 2 processes: 1 internal, 1 darwin-sandbox.
INFO: Build completed successfully, 2 total actions
```

Observe that `value with spaces` is not being quoted, and that the script received multiple arguments:

```console
➜  run-binary-repro git:(master) ✗ cat bazel-bin/repro_one.txt
• value
• with
• spaces
```

## Repro Two

Run `bazel build -s :repro_two`:

```console
➜  run-binary-repro git:(master) ✗ bazel build -s :repro_two
INFO: Analyzed target //:repro_two (96 packages loaded, 494 targets configured).
SUBCOMMAND: # //:repro_two [action 'RunBinary repro_two.txt', configuration: 096dcc84165363e69a851ebe8131b032f5448c94ddc4951775429dc78e79f898, execution platform: @@platforms//host:host, mnemonic: RunBinary]
(cd /private/var/tmp/_bazel_wburgin/cb3bef35f39127f502d8d180ce497830/execroot/_main && \
  exec env - \
  bazel-out/darwin_arm64-opt-exec-ST-d57f47055a04/bin/debug_args --output-file bazel-out/darwin_arm64-fastbuild/bin/repro_two.txt ''\''value' with 'spaces'\''')
# Configuration: 096dcc84165363e69a851ebe8131b032f5448c94ddc4951775429dc78e79f898
# Execution platform: @@platforms//host:host
INFO: Found 1 target...
Target //:repro_two up-to-date:
  bazel-bin/repro_two.txt
INFO: Elapsed time: 0.457s, Critical Path: 0.05s
INFO: 6 processes: 5 internal, 1 darwin-sandbox.
INFO: Build completed successfully, 6 total actions
```

Observe that the naive attempt at quoting the argument with spaces resulted in `''\''value' with 'spaces'\'''`, and an output of:

```console
➜  run-binary-repro git:(master) ✗ cat bazel-bin/repro_two.txt
• 'value
• with
• spaces'
```
