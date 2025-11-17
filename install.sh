#!/bin/bash

# Color
BLUE='\033[0;34m'       
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Variabel Direktori Pterodactyl
PTERO_DIR="/var/www/pterodactyl"

# Display welcome message
display_welcome() {
  echo -e ""
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                                                 [+]${NC}"
  echo -e "${BLUE}[+]                AUTO INSTALLER THEMA             [+]${NC}"
  echo -e "${BLUE}[+]                  © gudel023                     [+]${NC}"
  echo -e "${BLUE}[+]                                                 [+]${NC}"
  echo -e "${RED}[+] =============================================== [+]${NC}"
  echo -e ""
  echo -e "script ini di buat untuk mempermudah penginstalasian thema pterodactyl,"
  echo -e "dilarang keras untuk dikasih gratis."
  echo -e ""
  echo -e "𝗧𝗘𝗟𝗘𝗚𝗥𝗔𝗠 :"
  echo -e "@gudel023"
  echo -e "𝗖𝗥𝗘𝗗𝗜𝗧𝗦 :"
  echo -e "@gudel023"
  sleep 4
  clear
}

# Update and install jq
install_jq() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]             UPDATE & INSTALL JQ                 [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sudo apt update && sudo apt install -y jq
  if [ $? -eq 0 ]; then
    echo -e "                                                       "
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "${GREEN}[+]              INSTALL JQ BERHASIL                [+]${NC}"
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
  else
    echo -e "                                                       "
    echo -e "${RED}[+] =============================================== [+]${NC}"
    echo -e "${RED}[+]              INSTALL JQ GAGAL                   [+]${NC}"
    echo -e "${RED}[+] =============================================== [+]${NC}"
    exit 1
  fi
  echo -e "                                                       "
  sleep 1
  clear
}

# Check user token
check_token() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]               LICENSY gudel023                  [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  echo -e "${YELLOW}MASUKAN AKSES TOKEN :${NC}"
  read -r USER_TOKEN

  if [ "$USER_TOKEN" = "gudel023" ]; then
    echo -e "${GREEN}AKSES BERHASIL${NC}"
  else
    echo -e "${RED}TOKEN TIDAK VALID!${NC}"
    echo -e "${YELLOW}Buy dulu Gih Ke gudel023${NC}"
    echo -e "${YELLOW}TELEGRAM : @gudel023${NC}"
    echo -e "${YELLOW}WHATSAPP : 62882141700${NC}"
    echo -e "${YELLOW}HARGA TOKEN : 25K FREE UPDATE JIKA ADA TOKEN BARU${NC}"
    echo -e "${YELLOW}©gudel023${NC}"
    exit 1
  fi
  clear
}

# Deteksi direktori Pterodactyl
detect_ptero_dir() {
  if [ ! -d "$PTERO_DIR" ]; then
    echo -e "${YELLOW}Direktori Pterodactyl Panel standar ($PTERO_DIR) tidak ditemukan.${NC}"
    read -p "Masukkan direktori Pterodactyl Panel Anda (e.g., /var/www/pterodactyl): " CUSTOM_DIR
    if [ -d "$CUSTOM_DIR" ]; then
      PTERO_DIR="$CUSTOM_DIR"
      echo -e "${GREEN}Menggunakan direktori: $PTERO_DIR${NC}"
    else
      echo -e "${RED}Direktori $CUSTOM_DIR tidak ditemukan. Skrip dihentikan.${NC}"
      exit 1
    fi
  else
    echo -e "${GREEN}Direktori Pterodactyl Panel terdeteksi: $PTERO_DIR${NC}"
  fi
  sleep 1
}

# Install theme
install_theme() {
  local THEME_URL
  while true; do
    echo -e "                                                       "
    echo -e "${BLUE}[+] =============================================== [+]${NC}"
    echo -e "${BLUE}[+]                   SELECT THEME                  [+]${NC}"
    echo -e "${BLUE}[+] =============================================== [+]${NC}"
    echo -e "                                                       "
    echo -e "PILIH THEME YANG INGIN DI INSTALL"
    echo "1. stellar"
    echo "2. billing"
    echo "3. enigma"
    echo "x. kembali"
    echo -e "masukan pilihan (1/2/3/x) :"
    read -r SELECT_THEME
    case "$SELECT_THEME" in
      1)
        THEME_URL="https://github.com/gitfdil1248/thema/raw/main/C2.zip"
        break
        ;;
      2)
        THEME_URL="https://github.com/DITZZ112/foxxhostt/raw/main/C1.zip"
        break
        ;;
      3)
        THEME_URL="https://github.com/gitfdil1248/thema/raw/main/C3.zip"
        break
        ;; 
      x)
        return
        ;;
      *)
        echo -e "${RED}Pilihan tidak valid, silahkan coba lagi.${NC}"
        ;;
    esac
  done
  
  # Hapus direktori sementara jika ada
  if [ -e /root/pterodactyl ]; then
    sudo rm -rf /root/pterodactyl
  fi
  
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                  INSTALLASI THEMA               [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                                   "
  
  wget -q "$THEME_URL" -O /root/theme.zip
  
  if [ $? -ne 0 ]; then
    echo -e "${RED}Gagal mengunduh tema.${NC}"
    sudo rm -f /root/theme.zip
    return 1
  fi
  
  sudo unzip -o /root/theme.zip -d /root/
  
  if [ $? -ne 0 ]; then
    echo -e "${RED}Gagal mengekstrak tema.${NC}"
    sudo rm -f /root/theme.zip
    sudo rm -rf /root/pterodactyl # Tambahkan cleanup untuk direktori jika ada
    return 1
  fi
  
  # Khusus tema Enigma (Opsi 3)
  if [ "$SELECT_THEME" = "3" ]; then
    echo -e "${YELLOW}Masukkan link wa (https://wa.me...) : ${NC}"
    read LINK_WA
    echo -e "${YELLOW}Masukkan link group (https://.....) : ${NC}"
    read LINK_GROUP
    echo -e "${YELLOW}Masukkan link channel (https://...) : ${NC}"
    read LINK_CHNL

    # Mengganti placeholder dengan nilai dari pengguna
    # Pastikan file yang diunduh sudah ada di /root/pterodactyl
    sudo sed -i "s|LINK_WA|$LINK_WA|g" /root/pterodactyl/resources/scripts/components/dashboard/DashboardContainer.tsx
    sudo sed -i "s|LINK_GROUP|$LINK_GROUP|g" /root/pterodactyl/resources/scripts/components/dashboard/DashboardContainer.tsx
    sudo sed -i "s|LINK_CHNL|$LINK_CHNL|g" /root/pterodactyl/resources/scripts/components/dashboard/DashboardContainer.tsx
  fi
  
  # Salin tema ke direktori Pterodactyl
  sudo cp -rfT /root/pterodactyl "$PTERO_DIR"
  
  # Instalasi dependensi dan build (dipindahkan ke sini agar tidak berulang)
  echo -e "${YELLOW}Menginstal dependensi Node.js dan Yarn...${NC}"
  curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  sudo apt install -y nodejs
  sudo npm i -g yarn
  
  cd "$PTERO_DIR" || { echo -e "${RED}Direktori Pterodactyl tidak ditemukan. Aborted.${NC}"; return 1; }
  
  echo -e "${YELLOW}Melakukan instalasi dependensi dan build...${NC}"
  yarn add react-feather
  php artisan migrate
  yarn build:production
  php artisan view:clear
  
  # Cleanup
  sudo rm -f /root/theme.zip
  sudo rm -rf /root/pterodactyl

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                   INSTALL SUCCESS               [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e ""
  sleep 2
  clear
}

# Uninstall theme
uninstall_theme() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    DELETE THEME                 [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  # Pastikan direktori Pterodactyl sudah terdeteksi
  if [ ! -d "$PTERO_DIR" ]; then
      echo -e "${RED}Direktori Pterodactyl Panel tidak ditemukan di $PTERO_DIR.${NC}"
      sleep 2
      return
  fi

  bash <(curl -s https://raw.githubusercontent.com/gitfdil1248/thema/main/repair.sh) "$PTERO_DIR"
  
  if [ $? -eq 0 ]; then
    echo -e "                                                       "
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "${GREEN}[+]                 DELETE THEME SUKSES             [+]${NC}"
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
  else
    echo -e "                                                       "
    echo -e "${RED}[+] =============================================== [+]${NC}"
    echo -e "${RED}[+]                 DELETE THEME GAGAL              [+]${NC}"
    echo -e "${RED}[+] =============================================== [+]${NC}"
  fi
  echo -e "                                                       "
  sleep 2
  clear
}

# Fungsi ini dihapus/diganti karena redundant dengan opsi 1 di install_theme
install_themeSteeler() {
  echo -e "${YELLOW}Menggunakan fungsi Install theme (Opsi 1) untuk Stellar Theme...${NC}"
  SELECT_THEME="1"
  THEME_URL="https://github.com/gitfdil1248/thema/raw/main/C2.zip"

  if [ -e /root/pterodactyl ]; then
    sudo rm -rf /root/pterodactyl
  fi

  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                  INSTALLASI THEMA STELLER       [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                                   "
  
  wget -q "$THEME_URL" -O /root/theme.zip
  sudo unzip -o /root/theme.zip -d /root/
  
  sudo cp -rfT /root/pterodactyl "$PTERO_DIR"
  
  # Instalasi dependensi dan build
  echo -e "${YELLOW}Menginstal dependensi Node.js dan Yarn...${NC}"
  curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  sudo apt install -y nodejs
  sudo npm i -g yarn
  
  cd "$PTERO_DIR" || { echo -e "${RED}Direktori Pterodactyl tidak ditemukan. Aborted.${NC}"; return 1; }

  echo -e "${YELLOW}Melakukan instalasi dependensi dan build...${NC}"
  yarn add react-feather
  php artisan migrate
  yarn build:production
  php artisan view:clear
  
  # Hapus file dan direktori sementara
  sudo rm -f /root/theme.zip
  sudo rm -rf /root/pterodactyl

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                   INSTALL SUCCESS               [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e ""
  sleep 2
  clear
}

create_node() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    CREATE NODE                  [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  # Minta input dari pengguna
  read -p "Masukkan nama lokasi: " location_name
  read -p "Masukkan deskripsi lokasi: " location_description
  read -p "Masukkan domain: " domain
  read -p "Masukkan nama node: " node_name
  read -p "Masukkan RAM (dalam MB): " ram
  read -p "Masukkan jumlah maksimum disk space (dalam MB): " disk_space
  read -p "Masukkan Locid: " locid

  # Ubah ke direktori pterodactyl
  cd "$PTERO_DIR" || { echo -e "${RED}Direktori Pterodactyl tidak ditemukan. Aborted.${NC}"; exit 1; }

  # Membuat lokasi baru
  echo -e "${YELLOW}Membuat lokasi baru...${NC}"
  php artisan p:location:make <<EOF
$location_name
$location_description
EOF

  # Membuat node baru
  echo -e "${YELLOW}Membuat node baru...${NC}"
  php artisan p:node:make <<EOF
$node_name
$location_description
$locid
https
$domain
yes
no
no
$ram
$ram
$disk_space
$disk_space
100
8080
2022
/var/lib/pterodactyl/volumes
EOF

  # Mendapatkan ID node yang baru dibuat (node terakhir)
  NODE_ID=$(php artisan p:node:list --format=json | jq -r '.[-1].id')
  
  if [ -z "$NODE_ID" ] || [ "$NODE_ID" = "null" ]; then
    echo -e "${RED}Gagal mendapatkan ID node${NC}"
    exit 1
  fi

  # Membuat configuration token untuk node
  CONFIG_TOKEN=$(php artisan p:node:configuration $NODE_ID --format=json | jq -r '.token')
  
  if [ -z "$CONFIG_TOKEN" ] || [ "$CONFIG_TOKEN" = "null" ]; then
    echo -e "${RED}Gagal membuat configuration token${NC}"
    exit 1
  fi

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]        CREATE NODE & LOCATION SUKSES           [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  echo -e "${YELLOW}Configuration Token: $CONFIG_TOKEN${NC}"
  echo -e "                                                       "
  
  sleep 2
  clear

  # Otomatis menjalankan configure_wings dengan token yang didapat
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]           AUTO CONFIGURE WINGS                  [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "

  # Menjalankan configure wings dengan token yang didapat
  # Perintah config wings biasanya merupakan perintah bash yang diawali 'bash <(curl -s ...)'
  # Oleh karena itu, kita jalankan eval pada token yang didapat
  eval "$CONFIG_TOKEN"
  
  # Menjalankan perintah systemctl start wings
  sudo systemctl start wings

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]            CONFIGURE WINGS SUKSES              [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  sleep 2
  clear
}

uninstall_panel() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    UNINSTALL PANEL              [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  echo -e "${RED}PERINGATAN: Ini akan menghapus Pterodactyl Panel dan data terkait.${NC}"
  read -p "Lanjutkan? (y/N): " confirm_uninstall
  
  if [[ "$confirm_uninstall" != "y" && "$confirm_uninstall" != "Y" ]]; then
    echo -e "${YELLOW}Uninstall dibatalkan.${NC}"
    sleep 1
    return
  fi

  # Menggunakan skrip uninstall Pterodactyl Installer
  bash <(curl -s https://pterodactyl-installer.se/uninstall)
  
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 UNINSTALL PANEL SELESAI        [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}

hackback_panel() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    HACK BACK PANEL              [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  # Minta input dari pengguna
  read -p "Masukkan Email Panel: " email
  read -p "Masukkan Username Panel (First Name): " user_first
  read -p "Masukkan Username Panel (Last Name): " user_last
  read -p "Masukkan Username Panel: " user
  read -p "Masukkan password login: " psswdhb
  
  cd "$PTERO_DIR" || { echo -e "${RED}Direktori Pterodactyl tidak ditemukan. Aborted.${NC}"; exit 1; }

  # Membuat user baru
  echo -e "${YELLOW}Membuat user administrator baru...${NC}"
  php artisan p:user:make <<EOF
yes
$email
$user_first
$user_last
$user
$psswdhb
EOF

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 AKUN TELAH DI ADD              [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
}

ubahpw_vps() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                    UBAH PASSWORD VPS           [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  read -s -p "Masukkan Pw Baru: " pw
  echo # newline
  read -s -p "Masukkan Ulang Pw Baru: " pw_confirm
  echo # newline

  if [ "$pw" != "$pw_confirm" ]; then
    echo -e "${RED}Password tidak cocok!${NC}"
    return 1
  fi

  echo -e "root:$pw" | sudo chpasswd

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 GANTI PW VPS SUKSES            [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
}

# Configure Wings
configure_wings() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                  CONFIGURE WINGS                [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  read -p "Masukkan Configuration Token: " config_token
  
  # Menjalankan configure wings dengan token yang dimasukkan
  eval "$config_token"
  
  # Restart wings service
  sudo systemctl restart wings

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]            CONFIGURE WINGS SUKSES              [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  sleep 2
  clear
}

# Create new nest
create_nest() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    CREATE NEST                  [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  # Minta input dari pengguna
  read -p "Masukkan nama nest: " nest_name
  read -p "Masukkan deskripsi nest: " nest_description
  read -p "Masukkan author nest (e.g., Pterodactyl <support@pterodactyl.io>): " nest_author
  
  # Ubah ke direktori pterodactyl
  cd "$PTERO_DIR" || { echo -e "${RED}Direktori Pterodactyl tidak ditemukan. Aborted.${NC}"; exit 1; }

  # Membuat nest baru menggunakan artisan command
  echo -e "${YELLOW}Membuat nest baru...${NC}"
  php artisan p:nest:make <<EOF
$nest_name
$nest_description
$nest_author
EOF

  # Dapatkan ID nest yang baru dibuat
  NEST_ID=$(php artisan p:nest:list --format=json | jq -r '.[-1].id')
  
  if [ -z "$NEST_ID" ] || [ "$NEST_ID" = "null" ]; then
    echo -e "${RED}Gagal mendapatkan ID nest${NC}"
    exit 1
  fi

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 CREATE NEST SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  echo -e "${YELLOW}Nest ID: $NEST_ID${NC}"
  echo -e "                                                       "
  
  sleep 2
  clear
  
  # Tanya user apakah ingin langsung import egg
  read -p "Apakah ingin import egg sekarang? (y/n): " import_choice
  if [[ "$import_choice" = "y" || "$import_choice" = "Y" ]]; then
    import_egg "$NEST_ID"
  fi
}

# Import egg from external source
import_egg() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    IMPORT EGG                   [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  local nest_id
  # Jika nest_id tidak diberikan sebagai parameter, minta input
  if [ -z "$1" ]; then
    read -p "Masukkan ID nest tujuan: " nest_id
  else
    nest_id="$1"
    echo -e "${YELLOW}Menggunakan Nest ID: $nest_id${NC}"
  fi
  
  read -p "Masukkan URL raw JSON egg (contoh: dari GitHub): " egg_url
  
  # Validasi URL
  if [[ ! "$egg_url" =~ ^https?:// ]]; then
    echo -e "${RED}URL tidak valid!${NC}"
    return 1
  fi

  # Unduh file egg JSON
  echo -e "${YELLOW}Mengunduh file egg...${NC}"
  wget -q -O /tmp/egg.json "$egg_url"
  
  if [ $? -ne 0 ]; then
    echo -e "${RED}Gagal mengunduh file egg dari $egg_url${NC}"
    return 1
  fi

  # Validasi file JSON
  if ! jq empty /tmp/egg.json 2>/dev/null; then
    echo -e "${RED}File egg bukan format JSON yang valid${NC}"
    rm -f /tmp/egg.json
    return 1
  fi

  # Ubah ke direktori pterodactyl
  cd "$PTERO_DIR" || { echo -e "${RED}Direktori Pterodactyl tidak ditemukan. Aborted.${NC}"; exit 1; }

  # Import egg menggunakan artisan command
  echo -e "${YELLOW}Mengimpor egg...${NC}"
  php artisan p:egg:import --nest="$nest_id" /tmp/egg.json

  if [ $? -eq 0 ]; then
    echo -e "                                                       "
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "${GREEN}[+]                 IMPORT EGG SUKSES              [+]${NC}"
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "                                                       "
  else
    echo -e "                                                       "
    echo -e "${RED}[+] =============================================== [+]${NC}"
    echo -e "${RED}[+]                 IMPORT EGG GAGAL                [+]${NC}"
    echo -e "${RED}[+] =============================================== [+]${NC}"
    echo -e "                                                       "
  fi

  # Bersihkan file temporary
  rm -f /tmp/egg.json
  
  sleep 2
  clear
}

# List all nests
list_nests() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    LIST NESTS                   [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  cd "$PTERO_DIR" || { echo -e "${RED}Direktori Pterodactyl tidak ditemukan. Aborted.${NC}"; exit 1; }

  # Menampilkan daftar nests dalam format JSON dan parsing dengan jq
  echo -e "${YELLOW}Daftar Nests:${NC}"
  php artisan p:nest:list --format=json | jq -r '.[] | "ID: \(.id) | Name: \(.name) | Author: \(.author) | Description: \(.description)"'
  
  echo -e "                                                       "
  read -p "Tekan Enter untuk melanjutkan..." dummy
  clear
}

# List eggs in a nest
list_eggs() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    LIST EGGS                    [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  read -p "Masukkan ID nest: " nest_id
  
  cd "$PTERO_DIR" || { echo -e "${RED}Direktori Pterodactyl tidak ditemukan. Aborted.${NC}"; exit 1; }

  # Menampilkan daftar eggs dalam nest tertentu
  echo -e "${YELLOW}Daftar Eggs dalam Nest ID $nest_id:${NC}"
  php artisan p:egg:list --nest="$nest_id" --format=json | jq -r '.[] | "ID: \(.id) | Name: \(.name) | Author: \(.author)"'
  
  echo -e "                                                       "
  read -p "Tekan Enter untuk melanjutkan..." dummy
  clear
}

# Main script
display_welcome
install_jq
check_token
detect_ptero_dir

while true; do
  clear
  echo -e "                                                                     "
  echo -e "${BLUE}        _,gggggggggg.                                     ${NC}"
  echo -e "${BLUE}    ,ggggggggggggggggg.                                   ${NC}"
  echo -e "${BLUE}  ,ggggg        gggggggg.                                 ${NC}"
  echo -e "${BLUE} ,ggg'               'ggg.                                ${NC}"
  echo -e "${BLUE}',gg       ,ggg.      'ggg:                               ${NC}"
  echo -e "${BLUE}'ggg      ,gg'''  .    ggg       Auto Installer gudel023 Private   ${NC}"
  echo -e "${BLUE}gggg      gg     ,     ggg      ------------------------  ${NC}"
  echo -e "${BLUE}ggg:     gg.     -   ,ggg       • Telegram : t.me/gudel023     ${NC}"
  echo -e "${BLUE} ggg:     ggg._    _,ggg        • Creadit  : gudel023 ${NC}"
  echo -e "${BLUE} ggg.    '.'''ggggggp           • Support by gudel023  ${NC}"
  echo -e "${BLUE}  'ggg    '-.__                                           ${NC}"
  echo -e "${BLUE}    ggg                                                   ${NC}"
  echo -e "${BLUE}      ggg                                                 ${NC}"
  echo -e "${BLUE}        ggg.                                              ${NC}"
  echo -e "${BLUE}          ggg.                                            ${NC}"
  echo -e "${BLUE}             b.                                           ${NC}"
  echo -e "                                                                     "
  echo -e "BERIKUT LIST INSTALL (Panel Dir: $PTERO_DIR):"
  echo "1. Install theme"
  echo "2. Uninstall theme"
  echo "3. Configure Wings"
  echo "4. Create Node"
  echo "5. Uninstall Panel (Hapus Panel)"
  echo "6. Stellar Theme (Sama dengan Opsi 1)"
  echo "7. Hack Back Panel (Tambah Admin Baru)"
  echo "8. Ubah Pw Vps"
  echo "9. Create Nest"
  echo "10. Import Egg"
  echo "11. List Nests"
  echo "12. List Eggs"
  echo "x. Exit"
  echo -e "Masukkan pilihan 1-12/x:"
  read -r MENU_CHOICE
  clear

  case "$MENU_CHOICE" in
    1)
      install_theme
      ;;
    2)
      uninstall_theme
      ;;
    3)
      configure_wings
      ;;
    4)
      create_node
      ;;
    5)
      uninstall_panel
      ;;
    6)
      install_themeSteeler # Tetap panggil fungsi, tapi sudah diperbaiki
      ;;
    7)
      hackback_panel
      ;;
    8)
      ubahpw_vps
      ;;
    9)
      create_nest
      ;;
    10)
      import_egg
      ;;
    11)
      list_nests
      ;;
    12)
      list_eggs
      ;;
    x)
      echo "Keluar dari skrip."
      exit 0
      ;;
    *)
      echo "Pilihan tidak valid, silahkan coba lagi."
      sleep 1
      ;;
  esac
done

