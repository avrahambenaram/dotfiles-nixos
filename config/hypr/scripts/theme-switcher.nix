{ config, pkgs }:

pkgs.writers.writePython3Bin "theme-switcher" {} ''
import os
import shutil
import subprocess

HOME = os.environ['HOME']
CONFIGDIR = "${config.xdg.configHome}"

if not os.path.exists(f"{CONFIGDIR}/.themes"):
    subprocess.run([
        'git',
        'clone',
        'https://github.com/avrahambenaram/nix-themes.git',
        f'{CONFIGDIR}/.themes'
    ])


def isNeovimRunning():
    try:
        # Use pgrep to check for Neovim process
        subprocess.check_output(["pgrep", "-x", "nvim"])
        return True
    except subprocess.CalledProcessError:
        return False


def main(theme):
    # Restarting services
    subprocess.run(['pkill', 'waybar'])

    # Remove and copy styles for Wofi
    shutil.copyfile(
        f'{CONFIGDIR}/.themes/wofi/style-base.css',
        f'{CONFIGDIR}/wofi/style.css'
    )
    shutil.copyfile(
        f'{CONFIGDIR}/.themes/wofi/style.widgets-base.css',
        f'{CONFIGDIR}/wofi/style.widgets.css'
    )

    if theme == "baskerville":
        apply_theme_baskerville()
    elif theme == "boxuk":
        apply_theme_boxuk()
    elif theme == "miasma":
        apply_theme_miasma()
    elif theme == "rose-pine":
        apply_theme_rose_pine()
    elif theme == "dracula":
        apply_theme_dracula()
    elif theme == "catppuccin":
        apply_theme_catppuccin()
    elif theme == "nord":
        apply_theme_nord()


def apply_theme_baskerville():
    apply_theme(
        "baskerville",
        "#a11c1c",
        "rgba(0, 0, 0, 0.8)",
        "#a11c1c",
        "sonokai",
        "#444",
        "#222",
        "#555",
        "TTY",
        "#E7C664",
        "#FC5D7C"
    )


def apply_theme_boxuk():
    apply_theme(
        "boxuk",
        "#148b85",
        "#262e37",
        "#148b85",
        "boxuk-contrast",
        "#111519",
        "#07080a",
        "#262e37",
        "matcha-dark-sea",
        "#FFA500",
        "#E60607"
    )


def apply_theme_miasma():
    apply_theme(
        "miasma",
        "#c9a554",
        "#222222",
        "#222222",
        "miasma",
        "#444",
        "#222",
        "#555",
        "gruvbox_material_dark",
        "#685742",
        "#b36d43"
    )


def apply_theme_rose_pine():
    apply_theme(
        "rose-pine",
        "#9ccfd8",
        "#232136",
        "#393552",
        "rose-pine",
        "#444",
        "#232136",
        "#555",
        "TTY",
        "#F6C177",
        "#EB6F92"
    )


def apply_theme_dracula():
    apply_theme(
        "dracula",
        "#bd93f9",
        "#282a36",
        "#44475a",
        "dracula",
        "#444",
        "#282a36",
        "#555",
        "dracula",
        "#FFB86C",
        "#FF5555"
    )


def apply_theme_catppuccin():
    apply_theme(
        "catppuccin",
        "#ca9ee6",
        "#303446",
        "#414559",
        "catppuccin-frappe",
        "#51576d",
        "#303446",
        "#414559",
        "catppuccin-frappe",
        "#e5c890",
        "#e78284"
    )


def apply_theme_nord():
    apply_theme(
        "nord",
        "#81a1c1",
        "#3b4252",
        "#44475a",
        "nord",
        "#2e3440",
        "#3b4252",
        "#2f3441",
        "nord",
        "#d08770",
        "#bf616a"
    )


def apply_theme(
        theme_name,
        color_highlight,
        color_base1,
        color_border1,
        nvim_theme,
        wofibase,
        wofibase1,
        wofibase2,
        btop_theme,
        color_warning,
        color_critical
        ):
    # Create symbolic links for config files
    create_symlink(
        f"{CONFIGDIR}/.themes/hypr/{theme_name}.conf",
        f"{CONFIGDIR}/hypr/theme.conf"
    )
    create_symlink(
        f"{CONFIGDIR}/.themes/cava/{theme_name}",
        f"{CONFIGDIR}/cava/config"
    )
    create_symlink(
        f"{CONFIGDIR}/.themes/hypr/lock/{theme_name}.sh",
        f"{CONFIGDIR}/hypr/lock.sh"
    )

    # Update Waybar style
    with open(f"{CONFIGDIR}/waybar/colors.css", "w") as f:
        colors = [
            f"@define-color highlight {color_highlight} ",
            f"@define-color base1 {color_base1}",
            f"@define-color border1 {color_border1}",
            f"@define-color warning {color_warning}",
            f"@define-color critical {color_critical};"
        ]
        f.write(
            ";\n".join(colors)
        )
        f.close()

    # Update Alacritty config
    create_symlink(
        f"{CONFIGDIR}/.themes/alacritty/{theme_name}.yml",
        f"{CONFIGDIR}/alacritty/theme.yml"
    )

    # Update NVIM theme
    with open(f"{HOME}/.nvimtheme", "w") as f:
        f.write(nvim_theme)

    # Update btop
    with open(f"{CONFIGDIR}/btop/btop.conf", "w") as f:
        f.write(f'color_theme = "{btop_theme}"\nvim_keys = True')

    # Update WOFI
    with open(f"{CONFIGDIR}/wofi/style.css", "a") as f:
        colors = [
            f"@define-color highlight {color_highlight}",
            f"@define-color base1 {wofibase}",
            f"@define-color base2 {wofibase1}",
            f"@define-color base3 {wofibase2};"
        ]
        f.write(
            ";\n".join(colors)
        )
    with open(f"{CONFIGDIR}/wofi/style.widgets.css", "a") as f:
        colors = [
            f"@define-color highlight {color_highlight}",
            f"@define-color base1 {wofibase}",
            f"@define-color base2 {wofibase1}",
            f"@define-color base3 {wofibase2};"
        ]
        f.write(
            ";\n".join(colors)
        )
    subprocess.run([
        'hyprctl',
        'reload'
    ])

    # Write file for bg cycle
    with open(f"{HOME}/.bgcycle", "w") as f:
        f.write(theme_name)

    # Clean bg-cycle
    subprocess.run(['rm', f'{HOME}/.bg'])

    if isNeovimRunning():
        subprocess.run(
            f'nvr -c "colorscheme {nvim_theme}"',
            shell=True
        )
        subprocess.run(
            'nvr -c "hi Normal guibg=DARK"',
            shell=True
        )


def create_symlink(src, dst):
    if os.path.exists(dst):
        os.remove(dst)
    os.symlink(src, dst)


if __name__ == "__main__":
    import sys
    main(sys.argv[1])
''
