# homebrew-tap

Homebrew tap for [@oberbichler](https://github.com/oberbichler)'s tools.

## Usage

```sh
brew tap oberbichler/tap
brew install oberbichler/tap/<formula>
```

Or install directly without tapping first:

```sh
brew install oberbichler/tap/<formula>
```

## Formulas

_None yet._

## Adding a formula

Formulas live in `Formula/` as `<name>.rb`. Create one from a release tarball with:

```sh
brew create --tap oberbichler/tap https://github.com/oberbichler/<repo>/archive/refs/tags/v<version>.tar.gz
```

Then check it before opening a pull request:

```sh
brew style oberbichler/tap
brew audit --strict --online --tap oberbichler/tap
brew install --build-from-source oberbichler/tap/<name>
brew test oberbichler/tap/<name>
```

## License

ISC — see [LICENSE](LICENSE).
