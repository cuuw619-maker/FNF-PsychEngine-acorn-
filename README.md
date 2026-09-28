# Acorn Engine

![Acorn Engine](logo.png)

A personal fork of Psych Engine for Friday Night Funkin', focused on a cleaner identity, mod support, editor tooling, and Windows builds.

## What is Acorn Engine?

Acorn Engine is based on Psych Engine and keeps its core modding workflow while applying Acorn branding and a few project-level changes.

### Included

- Psych Engine mod support
- Lua and HScript support on desktop
- Chart, character, stage and other editors
- Mod enable/disable management
- Achievements and Discord Rich Presence support
- Windows, Linux and macOS build targets
- Acorn Engine branding and application identity

## Building

### Windows

Install Haxe 4.3.4, HaxeFlixel/Lime dependencies and the required native libraries, then run:

```bat
haxelib run lime build Project.xml windows
```

The release executable is produced under:

```
export/release/windows/bin/
```

### Linux

```bash
haxelib run lime build Project.xml linux
```

### macOS

```bash
haxelib run lime build Project.xml mac
```

GitHub Actions also builds Windows, Linux and macOS automatically on pushes to `main`.

## Modding

Desktop builds support the `mods/` directory. See the original Psych Engine documentation and the files in this repository for the available scripting and editor APIs.

## Project identity

- Engine: **Acorn Engine**
- Application executable: **AcornEngine**
- Package: `com.cuuw619.acornengine`
- Version: **0.1.0**
- Base engine: Psych Engine

## Credits

Acorn Engine is a fork of Psych Engine. Original Psych Engine contributors retain credit for their work.

Psych Engine was created by Shadow Mario and Riveren, with contributions from many members of the FNF modding community.

Friday Night Funkin' was created by ninjamuffin99, PhantomArcade, Kawai Sprite and evilsk8r.

See the repository history and original project documentation for the complete upstream attribution.

## License

This project remains subject to the licenses included in the repository and the licenses of its dependencies and upstream components.
