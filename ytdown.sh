sudo zenity -h
if [ $? -eq 1 ]; then
	echo
    echo "|-_-| OOOPS! É necessário que instale a extenssão 'zenity'."
    echo
    echo ">> Tentanto instalar o 'zenity' automáticamente..."
    sudo apt install zenity
    if [ $? = 0 ]; then
        clear
        ytdown.sh
        else
            echo
            echo "#####################################################"
            echo "|-_-| OOOPS! Tivemos uma falha ao tentar instalar o 'zenity',"
            echo "tente instalar o zenity manualmente."
            echo "#####################################################"
            echo
            read -p "> Falha! Deseja sair?:" rp
            if [ $rp = "y" || $rp = "yes" || $rp = "s" || $rp = "sim" ]; then
                exit
                else
                    clear
                    ytdown.sh
            fi
    fi
fi
sudo ffmpeg -version
if [ $? -eq 1 ]; then
    zenity --info --text="Oops! É necessário que instale a extenssão 'ffmpeg'." --title="YTDOWN"
    clear
    echo
    echo ">> Tentanto instalar o 'ffmpeg' automáticamente..."
    sudo add-apt-repository ppa:jonathonf/ffmpeg-3
    sudo apt-get update
    sudo apt-get install ffmpeg
    if [ $? = 0 ]; then
        clear
        ytdown.sh
        else
        	echo
            echo "#####################################################"
            echo "|-_-| OOOPS!Tivemos uma falha ao tentar instalar o 'ffmpeg',"
            echo "mas você pode tentar instalar manualmente:"
            echo "Opção 1: https://ffmpeg.org/download.html"
            echo "Opção 2: https://launchpad.net/~jonathonf/+archive/ubuntu/ffmpeg-3"
            echo "Opção 3: https://launchpad.net/~jonathonf/+archive/ubuntu/tesseract"
            echo "#####################################################"
            echo
            read -p "> Falha! deseja sair?:" rp
            if [ $rp = "y" || $rp = "yes" || $rp = "s" || $rp = "sim" ]; then
                exit
                else
                    clear
                    ytdown.sh
            fi
    fi
fi
dire=//usr/share/applications
atalho=//usr/share/applications/YTDOWN.desktop
if [ ! -d $dire ]; then
    echo "[ERROR]"
else  
    if [ -e $atalho ]; then
    echo "[Ok]"
    else
    sudo cp //usr/local/bin/YTDOWN.desktop //usr/share/applications
    fi
fi
selection=$(zenity --list "VÍDEO" "MÚSICA" "PLAYLIST VÍDEOS" "PLAYLIST MÚSICAS" "ATUALIZAR" --column="" --text="Modo Download" --width=500 --height=230 --title="YTDOWN")
case "$selection" in
"VÍDEO")
link=$(zenity --entry --text="Insira o link" --width=300 --height=100 --title="YTDOWN")
clear
echo -------------------------------------------------------------
echo Download de $link para video/MP4:
echo -------------------------------------------------------------
cd ~/yt-video
vnum=$(ls | grep -e ".mp4" | wc -l) #numero de videos na pasta
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' $link -o "~/yt-video/%(title)s.%(ext)s" | zenity --progress --text="Download para video/MP4\n" --width=300 --height=100 --pulsate --title="YTDOWN" | youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' $link -o "~/yt-video/%(title)s.%(ext)s"
newvnum=$(ls | grep -e ".mp4" | wc -l)
if [ $vnum = $newvnum ]; then
	clear
    zenity --question --text="<big>Falha download!</big> \n Deseja tentar atualizar o YTDOWN?" --width=300 --height=150 --title="YTDOWN"
	if [ $? = 1 ]; then
        ytdown.sh
    else
        echo "Atualizando o engine do YTDOWN..."
        echo
        sudo youtube-dl -U
        if [ $? = 1 ]; then
            zenity --info --text="<big>Falha na atualização!</big>\n Verifique sua conexão..." --width=300 --height=100 --icon-name=error --title="YTDOWN"
            else
                zenity --info --text="Atualização realizada com êxito\n" --width=300 --height=100 --title="YTDOWN" --title="YTDOWN" 
                ytdown.sh
        fi
        fi
else
    echo
    echo "###########################################################"
    echo "###### O seu vídeo se encontra no diretório yt-video ######"
    echo "###########################################################"
    zenity --notification --text="Download com êxito! Video no diretório yt-video. \n Link: $link"
    ytdown.sh
fi
;;
"MÚSICA")
link=$(zenity --entry --text="Insira o link" --width=300 --height=100 --title="YTDOWN")
clear
echo -------------------------------------------------------------
echo Download de $link para audio/FLAC:
echo -------------------------------------------------------------
cd ~/yt-music
mnum=$(ls | grep -e ".flac" | wc -l)
youtube-dl -x --audio-format flac --audio-quality 0 $link -o "~/yt-music/%(title)s.%(ext)s" | zenity --progress --text="Download para audio/FLAC\n" --width=300 --height=100 --pulsate --title="YTDOWN"
newmnum=$(ls | grep -e ".flac" | wc -l)
if [ $mnum = $newmnum ]; then
    clear
    zenity --question --text="Falha download!\n Deseja tentar atualizar o YTDOWN?" --width=300 --height=100 --title="YTDOWN"
    if [ $? = 1 ]; then
        ytdown.sh
    else
        echo "Atualizando o engine do YTDOWN..."
        echo
        sudo youtube-dl -U
        if [ $? = 1 ]; then
            zenity --info --text="<big>Falha na atualização!</big>\n Verifique sua conexão..." --width=300 --height=100 --icon-name=error --title="YTDOWN"
            else
                zenity --info --text="Atualização realizada com êxito\n" --width=300 --height=100 --title="YTDOWN" --title="YTDOWN" 
                ytdown.sh
        fi
        fi
else
    echo
    echo "############################################################"
    echo "###### O seu música se encontra no diretório yt-music ######"
    echo "############################################################"
    zenity --notification --text="Download com êxito! Música no diretório yt-music. \n Link: $link"
    ytdown.sh
fi
;;
"PLAYLIST VÍDEOS")
link=$(zenity --entry --text="Insira o link" --width=300 --height=100 --title="YTDOWN")
clear
echo -------------------------------------------------------------
echo Download da playlist para video/MP4:
echo -------------------------------------------------------------
cd ~/yt-video/Playists
lvnum=$(ls -Rl Playists | egrep -c "^d") #Conta recursivamente todas as subpastas em Playists Obs: Conta recursivamente todos arquivos -> ls -Rl $pasta | egrep -c "^\-"
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' -o '~/yt-video/Playlists/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' $link | zenity --progress --text="Download playlist para video/MP4\n" --width=300 --height=100 --pulsate --title="YTDOWN"
newlvnum=$(ls -Rl Playists | egrep -c "^d")
if [ $lvnum = $newlvnum ]; then
    clear
    zenity --question --text="Falha download!\n Deseja tentar atualizar o YTDOWN?" --width=300 --height=100 --title="YTDOWN"
    if [ $? = 1 ]; then
        ytdown.sh
    else
        echo "Atualizando o engine do YTDOWN..."
        echo
        sudo youtube-dl -U
        if [ $? = 1 ]; then
            zenity --info --text="<big>Falha na atualização!</big>\n Verifique sua conexão..." --width=300 --height=100 --icon-name=error --title="YTDOWN"
            else
                zenity --info --text="Atualização realizada com êxito\n" --width=300 --height=100 --title="YTDOWN" --title="YTDOWN" 
                ytdown.sh
        fi
        fi
else
    echo
    echo "#################################################"
    echo "###### Playlist está em yt-video/Playlists ######"
    echo "#################################################"
    zenity --notification --text="Download com êxito! Playlist no diretório yt-video/Playlists. \n Link: $link"
fi
;;
"PLAYLIST MÚSICAS")
link=$(zenity --entry --text="Insira o link" --width=300 --height=100 --title="YTDOWN")
clear
echo -------------------------------------------------------------
echo Download da playlist para audio/FLAC:
echo -------------------------------------------------------------
cd ~/yt-music/Playists
lmnum=$(ls -Rl Playists | egrep -c "^d")
youtube-dl -x --audio-format flac --audio-quality 0 -o '~/yt-music/Playlists/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' $link | zenity --progress --text="Download para audio/FLAC\n" --width=300 --height=100 --pulsate --title="YTDOWN"
newlmnum=$(ls -Rl Playists | egrep -c "^d")
if [ $lmnum = $newlmnum ]; then
    clear
    zenity --question --text="Falha download!\n Deseja tentar atualizar o YTDOWN?" --width=300 --height=100 --title="YTDOWN"
    if [ $? = 1 ]; then
        ytdown.sh
    else
        echo "Atualizando o engine do YTDOWN..."
        echo
        sudo youtube-dl -U
        if [ $? = 1 ]; then
            zenity --info --text="<big>Falha na atualização!</big>\n Verifique sua conexão..." --width=300 --height=100 --icon-name=error --title="YTDOWN"
            else
                zenity --info --text="Atualização realizada com êxito\n" --width=300 --height=100 --title="YTDOWN" --title="YTDOWN" 
                ytdown.sh
        fi
        fi
else
    echo
    echo "#################################################"
    echo "###### Playlist está em yt-music/Playlists ######"
    echo "#################################################"
    zenity --notification --text="Download com êxito! Playlist no diretório yt-music/Playlists. \n Link: $link"
fi
;;
"ATUALIZAR")
        echo "Atualizando o engine do YTDOWN..."
        echo
        sudo youtube-dl -U
        if [ $? = 0 ]; then
            zenity --info --text="Atualização realizada com êxito\n" --width=300 --height=100 --title="YTDOWN" --title="YTDOWN"
            ytdown.sh 
            else
                zenity --info --text="<big>Falha na atualização!</big>\n Verifique sua conexão..." --width=300 --height=100 --icon-name=error --title="YTDOWN"
                ytdown.sh
        fi
;;
*)
clear
echo "##################################"
echo "###### Operação cancelada! #######"
echo "##################################"
echo
echo "Encontrou um bug?"
echo "Por favor reporte isso na aba do projeto: https://sourceforge.net/p/ytdown/discussion/"
zenity --question --text="Deseja executar novamente o YTDOWN?" --width=300 --height=100 --title="YTDOWN"
if [ $? = 0 ]; then
    ytdown.sh
else
    exit
fi
;;
esac
