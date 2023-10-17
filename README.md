# gh-upload

[GitHub CLI] extension for upload folders/files to `static` repo

## How it works

## Envs

```bash
GH_UPLOAD_REPO=<username>/static # default is static
```

## Usage

You need to create a repository named `static` first. You can use `gh repo create static --public` to create it.

```bash
gh extension install yuler/gh-upload
# Create alias dl => download
gh alias set up "upload"
gh up -h
```

