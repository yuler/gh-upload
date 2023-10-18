# gh-upload

[GitHub CLI] extension for upload folders/files to `static` repo

## How it works

- Create blob for every files
- Get latest sha from default branch
- Create tree w/ blobs and latest sha
- Post commit w/ tree and latest sha
- Update default branch ref

## Usage

You need to create a repository named `static` first. You can use `gh repo create static --public` to create it.

```bash
gh extension install yuler/gh-upload
# Create alias dl => download
gh alias set up "upload"
gh up -h
```
