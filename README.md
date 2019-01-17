# YTDOWN
Faça download de video e música nos mais populares websites de forma simples e rápido.

# O que é o YTDOWN?
O Ytdown é um arquivo shell Linux que usa o Youtube-dl como seu enigne, ou seja, como motor recorrente para as operações de download, porém de forma amigável ao usuário Linux.

# Instalação distribuições baseadas no Debian:
```
1. wget -c https://ufpr.dl.sourceforge.net/project/ytdown/Debian_Ytdown.tar.gz
2. echo export PATH="$PATH:/usr/local/bin/ytdown" >> ~/.profile; source ~/.profile
3. sudo tar -xf Debian_Ytdown.tar.gz -C //usr/local/bin; sudo chmod 755 //usr/local/bin/ytdown; ytdown.sh
```
# Instalação para Mageia:
```
1. wget -c https://ufpr.dl.sourceforge.net/project/ytdown/Mageia-Ytdown.tar.gz
2. su -c "tar -xf Mageia-Ytdown.tar.gz -C //usr/local/bin; chmod 755 //usr/local/bin/ytdown";
3. su -c "echo export PATH=$PATH:/usr/local/bin/ytdown >> ~/.bash_profile";
4. [Reinicie sua sessão][Abra o terminal] ytdown.sh
```

OBS: Se o Ytdown não for reconhecido como variável gobal do sistema, pode ser necessário reinicialização do sistema. Para outros casos relate ou instale novamente.
