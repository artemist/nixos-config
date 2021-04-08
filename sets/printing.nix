{ pkgs, ... }:

{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      (pkgs.brlaser.overrideAttrs (old: {
        patches = [
          (pkgs.fetchpatch {
            name = "l2300d-fix.patch";
            url = "https://patch-diff.githubusercontent.com/raw/pdewacht/brlaser/pull/68.patch";
            sha256 = "07iqv048q0iplghn0aamjslyixw1p5jbk004i20xnl1vs95nyqzy";
          })
        ];
      }))
    ];
  };
}
