{
  gtk4,
  glib,
  fetchFromGitHub,
  rustPlatform,
  lib,
  pkg-config,
  wrapGAppsHook4,
  ffmpeg,
  sqlite,
  openssl,
  gsettings-desktop-schemas
}:

rustPlatform.buildRustPackage rec {
  pname = "waytrogen";
  version = "0.5.7";
  preferLocalBuild = true;

  src = fetchFromGitHub {
    owner = "nikolaizombie1";
    repo = pname;
    rev = "0.5.4";
    hash = "sha256-JziGOVTYV/hmvMthEQBh1BS2yJD77jX5YkwuzqofGG8=";
  };  

  nativeBuildInputs = [ pkg-config glib wrapGAppsHook4 sqlite ];
  buildInputs = [ glib gtk4 ffmpeg sqlite openssl gsettings-desktop-schemas ];
  env = {
    OPENSSL_NO_VENDOR = 1;
  };
  
  cargoHash = "sha256-+BUkC88jFLBfGkfbMx6fc7wFTrayxkA4Nkw4EMphvfc=";

  postInstall = ''
  mkdir -p $out/share/glib-2.0/schemas && cp org.Waytrogen.Waytrogen.gschema.xml $out/share/glib-2.0/schemas/
  glib-compile-schemas $out/share/glib-2.0/schemas
  mkdir -p $out/share/locale/en/LC_MESSAGES && msgfmt locales/en/LC_MESSAGES/waytrogen.po -o waytrogen.mo && cp locales/en/LC_MESSAGES/waytrogen.mo $out/share/locale/en/LC_MESSAGES
  mkdir -p $out/share/locale/es/LC_MESSAGES && msgfmt locales/es/LC_MESSAGES/waytrogen.po -o waytrogen.mo && cp locales/es/LC_MESSAGES/waytrogen.mo $out/share/locale/es/LC_MESSAGES
  mkdir -p $out/share/applications && cp waytrogen.desktop $out/share/applications/
  '';

  meta = {
    description = "A lightning fast wallpaper setter for Wayland.";
    longDescription = "A GUI wallpaper setter for Wayland that is a spiritual successor for the minimalistic wallpaper changer for X11 nitrogen. Written purely in the Rust 🦀 programming language. Supports hyprpaper, swaybg, mpvpaper and swww wallpaper changers.";
    homepage = "https://github.com/nikolaizombie1/waytrogen";
    license = lib.licenses.unlicense;
    maintainers = [ ];
  };
}
