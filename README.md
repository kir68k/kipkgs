## Personal Nix package collection
This is a repository for derivations written by me that aren't in nixpkgs.

#### Current list of packages:
- Themes
    - `tokyonight-gtk`
        - TokyoNight theme for GTK
    - `tokyonight-kvantum`
        - TokyoNight theme for the Kvantum engine
- Programs
    - `nerdfetch`
        - A POSIX compliant system info script using NerdFonts
    - `spotify-adblock`
        - A library which blocks spotify's ad servers, effectively blocking ads
        - **This package is used by spotify-deb, as it's the only way I could get it to work on Nix >.>**
    - `spotify-deb`
        - The Spotify package, but using the debian release instead of Snap, which Nixpkgs uses
