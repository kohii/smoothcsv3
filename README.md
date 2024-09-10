# smoothcsv3

SmoothCSV 3 is the next generation of [SmoothCSV](https://github.com/kohii/smoothcsv) featuring a new UI, new features, and new technologies.

![SmoothCSV3](./screenshots/top.png)

## Status

This project is still a work in progress.

The source code is currently not public.
(I have not yet decided whether to make it open-source.)

## Download

An alpha version is available for testing.
Check the [releases](https://github.com/kohii/smoothcsv3/releases) page.
Currently, only macOS is supported.

Please note that the alpha version may contain bugs and may not be stable. Use it at your own risk.

Please report any bugs or feature requests to the [issue tracker](https://github.com/kohii/smoothcsv3/issues).

<details>
<summary>If you cannot open the app because it is damaged</summary>

<p align="center">
  <img src="./screenshots/damaged.png" width="320px" />
</p>

1. Open the Terminal app.
2. Run the following command.

```bash
xattr -r -d com.apple.quarantine "/Applications/SmoothCSV 3.app"
```
</details>

<details>
<summary>If you cannot open the app because the developer cannot be verified</summary>

1. Open `System Settings` app and go to `Security & Privacy`.
2. Click `Open Anyway` button.

If you cannot find the `Open Anyway` button, follow the steps below.

1. Open the Terminal app.
2. Run the following command.

```bash
xattr -r -d com.apple.quarantine "/Applications/SmoothCSV 3.app"
```

</details>

## Roadmap

- [x] Release alpha version
- [ ] Release beta version
  - [ ] Rename and rebrand the app
  - [ ] Implement all the features of the old SmoothCSV
  - [ ] Build a website
  - [ ] Updater
  - [ ] Settings
  - [ ] Localization for Japanese
  - [ ] Windows support
  - [ ] Dark mode
- [ ] Release stable version
  - [ ] Pay 99 USD to Apple for the Developer Program
  - [ ] Launch on Product Hunt
  - [ ] Localization for other languages
  - [ ] Improve performance
  - [ ] Improve stability
- [ ] In the future
  - [ ] Build extension system
  - [ ] Open source the project
  - [ ] Support other file formats
  - [ ] AI assistance

I would like this app to be considered the VSCode of the tabular editor in the future.
