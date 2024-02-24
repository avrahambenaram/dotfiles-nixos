{ config, pkgs }:

pkgs.writers.writePython3Bin "bg-cycle" {} ''
import subprocess
import os

HOME = os.environ['HOME']
CONFIGDIR = "${config.xdg.configHome}"

bgCycleTheme = open(f'{HOME}/.bgcycle', 'r')
bgTheme = bgCycleTheme.read()

subprocess.run(['touch', f'{HOME}/.bg'])
bgPaths = f'{CONFIGDIR}/.themes/bg/{bgTheme}/'
lsProcess = subprocess.run(
    ['ls', bgPaths],
    capture_output=True,
    text=True,
    check=True
)
files = lsProcess.stdout.split('\n')
files.remove("")

bgPosition = 0
with open(f'{HOME}/.bg', 'r+') as bgFile:
    content = bgFile.read()
    if content:
        bgPosition = int(content) + 1
        if bgPosition >= files.__len__():
            bgPosition = 0
    bgFile.seek(0)
    bgFile.write(str(bgPosition))
    bgFile.close()


bgImage = bgPaths + files[bgPosition]
subprocess.run(['swww', 'img', bgImage, '--transition-fps=120'])
''
