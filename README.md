# This mod likely will not be maintained

I no longer really play the game, so ongoing updates and fixes are unlikely.

# Gift Sorter

Sorts gifts by Health Shots, Mana Shots, Health Bombs, then remaining items alphabetically.

<!-- drh:show -->
Sorts gifts by Health Shots, Mana Shots, Health Bombs, then remaining items alphabetically.
<!-- /drh:show -->

- Health Shots first, Mana Shots second and Health Bombs third.
- Alphabetical sorting within each group, ignoring letter case.
- Preserves the native gift popup, item data and gifting controls.

## Requirements

Dungeon Rampage Haxe V17 and DRH Mod API 1.2 or a compatible later 1.x release. The launcher resolves the API dependency. This mod uses game internals and may need updates for later game releases.

## Installation

Install the release ZIP through the DRH Launcher Mods page. Do not use GitHub's automatic source-code ZIP as the release artifact.

To test a source checkout, run this from its repository folder with your launcher path:

```powershell
& "C:\Path\To\DRH-Launcher.com" --run-mod (Get-Location).Path
```

## Publishing

The included official workflow drafts a release when you push a `v<version>` tag matching `mod.json`. Test the generated ZIP before publishing the draft. Follow [Making a mod](https://github.com/Tutez64/Dungeon-Rampage-Haxe/blob/master/docs/making-a-mod.md) to submit the published release to the mod index.

## License

MIT. See [LICENSE](LICENSE).
