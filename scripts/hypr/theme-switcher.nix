{ pkgs }:

pkgs.writers.writePython3Bin "theme-switcher" {} ''
import os
import shutil
import subprocess

HOME = os.environ['HOME']

if not os.path.exists(f"{HOME}/.config/.themes"):
    subprocess.run([
        'git',
        'clone',
        'https://github.com/avrahambenaram/nix-themes.git',
        f'{HOME}/.config/.themes'
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

    # Remove and copy styles for Waybar
    shutil.copyfile(
        HOME + '/.config/.themes/waybar/base.css',
        HOME + '/.config/waybar/style.css'
    )

    # Remove and copy styles for Wofi
    shutil.copyfile(
        HOME + '/.config/.themes/wofi/style-base.css',
        HOME + '/.config/wofi/style.css'
    )
    shutil.copyfile(
        HOME + '/.config/.themes/wofi/style.widgets-base.css',
        HOME + '/.config/wofi/style.widgets.css'
    )

    if theme == "baskerville":
        apply_theme_baskerville()
    elif theme == "miasma":
        apply_theme_miasma()
    elif theme == "rose-pine":
        apply_theme_rose_pine()
    elif theme == "dracula":
        apply_theme_dracula()
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
        "#555"
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
        "#555"
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
        "#555"
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
        "#555"
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
        "#2f3441"
    )


def apply_theme(
        theme_name,
        color_highlight,
        color_base1,
        color_border1,
        nvim_theme,
        wofibase,
        wofibase1,
        wofibase2
        ):
    # Create symbolic links for config files
    create_symlink(
        f"{HOME}/.config/.themes/hypr/{theme_name}.conf",
        f"{HOME}/.config/hypr/theme.conf"
    )
    create_symlink(
        f"{HOME}/.config/.themes/cava/{theme_name}",
        f"{HOME}/.config/cava/config"
    )
    create_symlink(
        f"{HOME}/.config/.themes/hypr/lock/{theme_name}.sh",
        f"{HOME}/.config/hypr/lock.sh"
    )

    # Update Waybar style
    with open(f"{HOME}/.config/waybar/style.css", "a") as f:
        colors = [
            f"@define-color highlight {color_highlight} ",
            f"@define-color base1  {color_base1}",
            f"@define-color border1 {color_border1};"
        ]
        f.write(
            ";\n".join(colors)
        )

    # Update Alacritty config
    create_symlink(
        f"{HOME}/.config/.themes/alacritty/{theme_name}.yml",
        f"{HOME}/.config/alacritty/theme.yml"
    )

    # Update NVIM theme
    with open(f"{HOME}/.nvimtheme", "w") as f:
        f.write(nvim_theme)

    # Update WOFI
    with open(f"{HOME}/.config/wofi/style.css", "a") as f:
        colors = [
            f"@define-color highlight {color_highlight}",
            f"@define-color base1 {wofibase}",
            f"@define-color base2 {wofibase1}",
            f"@define-color base3 {wofibase2};"
        ]
        f.write(
            ";\n".join(colors)
        )
    with open(f"{HOME}/.config/wofi/style.widgets.css", "a") as f:
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

    if isNeovimRunning():
        subprocess.run(
            f'nvr -c "colorscheme {theme_name}"',
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
