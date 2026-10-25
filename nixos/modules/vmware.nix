{ config, pkgs, ... }:

{
  # 1. Гостевые утилиты VMware
  virtualisation.vmware.guest.enable = true;

  # 2. Графический стек и драйверы Mesa
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  # 3. Настройка Hyprland для виртуального окружения
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # 4. Переменные окружения для обхода ограничений графики VMware
  environment.sessionVariables = {
    # Отключение аппаратного курсора (критично для Hyprland в VM)
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # Разрешение программного рендеринга для Wayland-композитора
    WLR_RENDERER_ALLOW_SOFTWARE = "1";

    # Принудительный софтверный рендеринг Mesa (LLVMpipe) для стабильности Alacritty/QuickShell
    LIBGL_ALWAYS_SOFTWARE = "1";

    # Переменные совместимости для тулкитов и Electron-приложений
    QT_QPA_PLATFORM = "wayland;xcb";
    GDK_BACKEND = "wayland,x11";
  };

  # 5. Системные службы для инициализации GUI-сессий
  services.dbus.enable = true;
  security.polkit.enable = true;
}
