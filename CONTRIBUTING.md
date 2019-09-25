How to Contribute
=================

When contributing to this repository, please first discuss the change you wish
to make via issue with the owners of this repository before making a change.
Fixing typos or rephrasing for better understanding DO NOT require discussion.

## Branching Model

This repository holds two main branches with an infinite lifetime:
* `master` is the default branch which always reflects the latest release.
* `develop` is the main branch reflecting the latest delivered changes for the
  next release. When the `develop` branch reaches a stable point and is ready to
  be released, then all changes should be merged back into `master`.

A variety of supporting branches are used to aid parallel development. These
branches have a limited life time, since they will be removed eventually.

## Contributing

Contributions to this repository are welcome. For ease of managing, please
follow the steps below:

1. Fork this repository to your account
2. Clone your copy of this repository, locally
   ```
   git clone https://github.com/YOU/API-Security.git
   ```
3. Create a new branch based on `develop` (e.g. `fix/foreword-section`)
   ```
   git checkout develop && git checkout -b fix/foreword-section
   ```
4. Apply your changes.

   Please always follow our style conventions.

   Although there's an [`.editorconfig` file][1] on repository's root, your
   editor may not support it. To know more about [EditorConfig][2] and text
   editors/IDEs support check the website: https://editorconfig.org/
5. Commit your changes
   1. Check modified files and add only required ones (e.g. build artifacts
      SHOULD NOT be tracked)
   2. Commit message first line should provide a brief description of your
      changes. You can go into details on the optional commit message body.
6. Push changes to your public repository
   ```
   git push origin fix/foreword-section
   ```
7. Open a Pull Request from your `fix/foreword-section` to the upstream
   repository `develop` branch.

[1]: .editorconfig
[2]: https://editorconfig.org/
