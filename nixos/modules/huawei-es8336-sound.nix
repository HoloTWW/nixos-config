{ config, lib, pkgs, ... }:

let
  cfg = config.hardware.huaweiEs8336Sound;
in
{
  options.hardware.huaweiEs8336Sound.enable =
    lib.mkEnableOption "audio fix for Huawei laptop (Comet Lake + ES8336 codec)";

  config = lib.mkIf cfg.enable {
    # Прошивка и топологии для DSP (SOF). Драйвер и quirk ядро выбирает само,
    # никаких kernelParams/modprobe-опций не нужно.
    hardware.enableRedistributableFirmware = true;
    hardware.firmware = [ pkgs.sof-firmware ];

    # UCM не включает маршрут ЦАП -> Headphone Mixer, и без этого динамики
    # и наушники молчат. Громкость железа (Playback Volume) тоже нужна на максимум,
    # иначе звук тише примерно на 24 дБ.
    systemd.services.es8336-mixer = {
      description = "ES8336 mixer routing (Huawei)";
      wantedBy = [ "multi-user.target" ];
      after = [ "sound.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        amixer=${pkgs.alsa-utils}/bin/amixer
        # ждём появления карты (SOF грузит прошивку асинхронно)
        for i in $(seq 1 30); do
          $amixer -c sofessx8336 info >/dev/null 2>&1 && break
          sleep 1
        done
        $amixer -c sofessx8336 -q cset name='Left Headphone Mixer Left DAC Switch' on
        $amixer -c sofessx8336 -q cset name='Right Headphone Mixer Right DAC Switch' on
        $amixer -c sofessx8336 -q cset name='Headphone Playback Volume' 3,3
      '';
    };
  };
}
