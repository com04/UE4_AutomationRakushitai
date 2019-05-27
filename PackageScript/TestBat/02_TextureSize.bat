cd %~dp0\..
AutomationRakushitai.exe -windowed -LogCmds="global off,LogFunctionalTest log" -ExecCmds="Automation RunTests LV_TestTextureSize;Quit" -log=02_TextureSize.txt 
