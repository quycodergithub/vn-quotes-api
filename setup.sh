#!/bin/bash

# Kiểm tra xem có phải đang chạy trong môi trường root không
if [ "$EUID" -ne 0 ]; then
    echo "Vui lòng chạy script với quyền root."
    exit
fi

# Kiểm tra hệ điều hành
OS="$(uname -s)"
case "$OS" in
    Linux)
        if [[ $(uname -o) == *"Android"* ]]; then
            echo "Đang cài đặt trên Termux (Android)..."
            pkg update && pkg upgrade -y
            pkg install python git -y
        else
            echo "Đang cài đặt trên Linux..."
            apt update
            apt install python3 python3-pip git -y
        fi
        ;;
    Darwin)
        echo "Đang cài đặt trên macOS..."
        # Kiểm tra Homebrew
        if ! command -v brew &> /dev/null; then
            echo "Homebrew chưa được cài đặt. Đang tiến hành cài đặt Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew update
        brew install python git
        ;;
    *)
        echo "Hệ điều hành không được hỗ trợ!"
        exit 1
        ;;
esac

# Tải project từ GitHub nếu chưa có
if [ ! -d "./vn-quotes-api" ]; then
    echo "Cloning project repository..."
    git clone https://github.com/your-repo/project.git
fi

# Di chuyển vào thư mục project
cd vn-quotes-api

# Cài đặt các gói Python từ requirements.txt
if [ -f "requirements.txt" ]; then
    echo "Đang cài đặt các gói Python từ requirements.txt..."
    pip install -r requirements.txt
else
    echo "Không tìm thấy tệp requirements.txt"
fi

# Thông báo hoàn thành
echo "Hoàn tất cài đặt cho project!"
