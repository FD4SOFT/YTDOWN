sudo zenity -h
if [[ $? -eq 1 ]]; then
    echo "Oops! É necessário que instale a extenssão 'zenity'."
    clear
    echo
    echo ">> Tentanto instalar o 'zenity' automáticamente..."
    sudo apt install zenity
    if [[ $? -eq 0 ]]; then
        clear
        ytdown.sh
        else
            echo
            echo "Oops! Tivemos uma falha ao tentar instalar o 'ffmpeg', tente instalar o zenity manualmente."
            echo
            read -p "> Deseja sair?:" rp
            if [[ $rp = "y" || $rp = "yes" || $rp = "s" || $rp = "sim" ]]; then
                exit
                else
                    clear
                    ytdown.sh
            fi
    fi
fi
clear
sudo ffmpeg -version
if [[ $? -eq 1 ]]; then
    zenity --info --text="Oops! É necessário que instale a extenssão 'ffmpeg'." --title="YTDOWN"
    clear
    echo
    echo ">> Tentanto instalar o 'ffmpeg' automáticamente..."
    sudo add-apt-repository ppa:jonathonf/tesseract
    sudo apt-get update
    sudo apt-get install ffmpeg
    if [[ $? -eq 0 ]]; then
        clear
        ytdown.sh
        else
            echo
            echo "Oops!Tivemos uma falha ao tentar instalar o 'ffmpeg', mas você pode efetuar a instalação manualmente:"
            echo https://ffmpeg.org/download.html
            echo https://git.ffmpeg.org/ffmpeg.git ffmpeg
            echo
            read -p "> Deseja sair?:" rp
            if [[ $rp = "y" || $rp = "yes" || $rp = "s" || $rp = "sim" ]]; then
                exit
                else
                    clear
                    ytdown.sh
            fi
    fi
fi
clear
selection=$(zenity --list "VÍDEO" "MÚSICA" "PLAYLIST VÍDEOS" "PLAYLIST MÚSICAS" --column="" --text="Modo Download" --title="YTDOWN")
case "$selection" in

"VÍDEO")
link=$(zenity --entry --text="Insira o link" --title="YTDOWN")
clear
echo -------------------------------------------------------------
echo Download de $link para video/MP4:
echo -------------------------------------------------------------
#chmod -R a+rw ~/yt-video
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' $link -o "~/yt-video/%(title)s.%(ext)s"
if [[ $? -eq 1 ]]; then
    zenity --info --text="Oops! Houve algum erro, tente novamente." --title="YTDOWN"
    clear
    ytdown.sh
else
    echo
    echo "###########################################################"
    echo "###### O seu vídeo se encontra no diretório yt-video ######"
    echo "###########################################################"
fi
;;
"MÚSICA")
link=$(zenity --entry --text="Insira o link" --title="YTDOWN")
clear
echo -------------------------------------------------------------
echo Download de $link para audio/FLAC:
echo -------------------------------------------------------------
youtube-dl -x --audio-format flac --audio-quality 0 $link -o "~/yt-music/%(title)s.%(ext)s"
if [[ $? -eq 1 ]]; then
    zenity --info --text="Oops! Houve algum erro, tente novamente." --title="YTDOWN"
    clear
    ytdown.sh
else
    echo
    echo "###########################################################"
    echo "###### O seu vídeo se encontra no diretório yt-music ######"
    echo "###########################################################"
fi
;;
"PLAYLIST VÍDEOS")
link=$(zenity --entry --text="Insira o link" --title="YTDOWN")
clear
echo -------------------------------------------------------------
echo Download da playlist para video/MP4:
echo -------------------------------------------------------------
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' -o '~/yt-video/Playlists/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' $link
if [[ $? -eq 1 ]]; then
    zenity --info --text="Oops! Houve algum erro, tente novamente." --title="YTDOWN"
    clear
    ytdown.sh
else
    echo
    echo "##################################################"
    echo "###### Checa o diretório yt-video/Playlists ######"
    echo "##################################################"
fi
;;
"PLAYLIST MÚSICAS")
link=$(zenity --entry --text="Insira o link" --title="YTDOWN")
clear
echo -------------------------------------------------------------
echo Download da playlist para audio/FLAC:
echo -------------------------------------------------------------
youtube-dl -x --audio-format flac --audio-quality 0 -o '~/yt-music/Playlists/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' $link
if [[ $? -eq 1 ]]; then
    zenity --info --text="Oops! Houve algum erro, tente novamente." --title="YTDOWN"
    clear
    ytdown.sh
    exit
else
    echo
    echo "##################################################"
    echo "###### Checa o diretório yt-music/Playlists ######"
    echo "##################################################"
fi
;;
*)
clear
echo "##################################"
echo "###### Operação cancelada! #######"
echo "##################################"
echo
echo "Encontrou um bug? Por favor reporte isso na aba do projeto: https://sourceforge.net/p/ytdown/discussion/"
echo
read -p "> Deseja executar novamente o YTDOWN?:" rp
if [[ $rp = "y" || $rp = "yes" || $rp = "s" || $rp = "sim" ]]; then
    ytdown.sh
else
    exit
fi
;;
esac
