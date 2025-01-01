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
