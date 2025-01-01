
# Synology NAS Development (toolkit)

Develop packages for the Synology NAS platform.

## Example Usage

```json
"features": {
    "ghcr.io/ChaosWars/synology-features/toolkit:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| architecture | Choose NAS architecture. | string | geminilake |
| dsmVersion | Choose DSM version. | string | 7.2 |
| toolkitPath | Choose toolkit path. | string | /toolkit |
| pkgscriptsDir | Pkgscripts directory. It is relative to the toolkit directory. | string | pkgscripts-ng |

## Synology toolkit for NAS Development

Synology toolkit scripts will be downloaded to `/toolkit/pkgscripts-ng` by default. `/toolkit` is mounted as a docker volume.

### Usage

```jsonc
{
    "features": {
        "ghcr.io/ChaosWars/synology-features/toolkit:1": {
            "dsmVersion": "7.2",
            "architecture": "geminilake"
        }
    },
    "image": "mcr.microsoft.com/devcontainers/base:1-jammy",
    "init": true,
    "privileged": true,
    "remoteUser": "root"
}
```

Note that the `privileged` and `remoteUser` settings are required for the Synology toolkit to work correctly.

### Development

After this you can run any of the scripts in the `/toolkit/pkgscript-ng` directory as you normally would when developing packages for Synology NAS.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/ChaosWars/synology-features/blob/main/src/toolkit/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
