
# LLVM (llvm)

Install LLVM compiler toolchain

## Example Usage

```json
"features": {
    "ghcr.io/ChaosWars/vscode-features/llvm:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| llvm-version | The version of LLVM to install. | string | 19 |

## LLVM toolchain

LLVM toolchain will be downloaded and installed via apt-get.

### Usage

```jsonc
{
    "features": {
        "ghcr.io/ChaosWars/vscode-features/llvm:1": {}
    },
    "image": "mcr.microsoft.com/devcontainers/base:1-noble"
}
```


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/ChaosWars/vscode-features/blob/main/src/llvm/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
