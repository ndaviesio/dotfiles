# Dotfiles

**This configuration only currently supports macOS systems**

## Prequisites
macOS no longer ships with `git`. Install through the XCode Command Line Tools
```bash
xcode-select --install
```

## Deploy
To deploy this configuration on a new system, use the following command.
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ndaviesio
```

### More
- [https://chezmoi.io/reference/](https://chezmoi.io/reference/)