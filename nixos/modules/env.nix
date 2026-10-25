{
  environment.variables = {
    EDITOR = "nano";
    RANGER_LOAD_DEFAULT_RC = "FALSE";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GSETTINGS_BACKEND = "keyfile";
  };
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };
}
