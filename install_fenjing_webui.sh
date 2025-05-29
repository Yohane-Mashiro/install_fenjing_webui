#!/bin/bash
if ! command -v pipx &> /dev/null; then
    echo "正在安装 pipx..."
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath
    source ~/.bashrc
fi

echo "正在安装 fenjing..."
pipx install fenjing

DESKTOP_DIR="$HOME/Desktop"
if [ ! -d "$DESKTOP_DIR" ]; then
    DESKTOP_DIR="$HOME/桌面"
    if [ ! -d "$DESKTOP_DIR" ]; then
        echo "无法找到桌面目录，将在主目录创建快捷方式"
        DESKTOP_DIR="$HOME"
    fi
fi

ICON_DIR="$HOME/.local/share/icons"
mkdir -p "$ICON_DIR"

echo "正在下载图标..."
wget -q "https://raw.githubusercontent.com/Marven11/Fenjing/main/assets/fenjing.webp" -O "$ICON_DIR/fenjing.webp"

echo "正在创建桌面快捷方式..."
cat > "$HOME/.local/share/applications/fenjing.desktop" << EOF
[Desktop Entry]
Type=Application
Version=1.0
Name=Fenjing
Comment=Fenjing Web UI
Exec=bash -c "/usr/bin/xdg-open http://127.0.0.1:11451/;$HOME/.local/bin/fenjing webui"
Icon=$ICON_DIR/fenjing.webp
Terminal=false
Categories=Education;Python;Development
EOF

chmod +x "$HOME/.local/share/applications/fenjing.desktop"

echo "Fenjing 安装完成！"
