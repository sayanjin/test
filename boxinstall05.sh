#!/bin/bash
# boxinstall.sh - postinstall d'openbox
# pour un environnement fonctionnel
#version 04
DIALOG={DIALOG=dialog}
INPUT=/tmp/menu.sh.$$
 
# Storage file for displaying cal and date command output
OUTPUT=/tmp/output.sh.$$
 

# trap and delete temp files
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM
 
#
# Purpose - display output using msgbox 
#  $1 -> set msgbox height
#  $2 -> set msgbox width
#  $3 -> set msgbox title
#
function display_output(){
	local h=${1-10}			# box height default 10
	local w=${2-41} 		# box width default 41
	local t=${3-Output} 	# box title 
	dialog --backtitle "postconfiguration openbox" --title "${t}" --clear --msgbox "$(<$OUTPUT)" ${h} ${w}
}
#
# Purpose - display current system date & time
#
	
function boxy (){
	get xorg
	get openbox
	mkdir /etc/skel/.config
	cp -rf /etc/xdg/openbox /etc/skel/.config/openbox
	mkdir /root/.config
	cp -rf /etc/xdg/openbox /root/.config/openbox
	
}

  # Install lxdm
  function lxdm (){
    get lxdm
    sed -i "s/id:3:initdefault:/id:4:initdefault:/1" /etc/inittab*
  }
  
  
  ## Install startx
  #function stax (){
    echo openbox > ~/.xinitrc
    cp ~/.xinitrc /etc/skel
  #}
  
   # Install Thunar
  function thun (){
	get tango-icon-theme
    get tango-icon-theme-extras
    get gnome-icon-theme
    get thunar 
    get thunar-volman 
    get gvfs 
   # possibilte d'ajouter les liens dns le menu d'openbox 
   # et de modifier le theme selon
  }
  
  # alsa-utils
  function util (){
	  get alsa-utils
}

  # gstreamer
  function gst0 (){
	  get gstreamer
}
  # gstreamer-plugins-bad
  function bad0 (){
	  get gstreamer-plugins-bad
}
  # gstreamer-plugins-base
  function base (){
	  get gstreamer-plugins-base
}
  # gstreamer-plugins-ffmpeg
  function ffmp (){
	  get gstreamer-plugins-ffmpeg
}
  # gstreamer-plugins-good
  function good (){
	  get gstreamer-plugins-good
}
  # gstreamer-plugins-python
  function pyth (){
	  get gstreamer-plugins-python
}
  # gstreamer-plugins-ugly
  function ugly (){
	  get gstreamer-plugins-ugly
}
  # gstreamer1
  function menu (){
	  get gstreamer1
}
  # gstreamer1-libav
  function gsli (){
	  get gstreamer1-libav
}
  # gstreamer1-plugins-bad
  function bad1 (){
	  get gstreamer1-plugins-bad
}
  # gstreamer1-plugins-base
  function bas1 (){
	  get gstreamer1-plugins-base
}
  # gstreamer1-plugins-good
  function goo1 (){
	  get gstreamer1-plugins-good
}
  # gstreamer1-plugins-libav
  function liba (){
	  get gstreamer1-plugins-libav
}
  # gstreamer1-plugins-ugly
  function ugl1 (){
	  get gstreamer1-plugins-ugly
}
  
  #wbar
  function wbar (){
	  get wbar
	  sed -i '$a\\ wbar &' /etc/skel/.config/openbox/autostart
      sed -i '$a\\ wbar &' /root/.config/openbox/autostart
}
  #obmenu
  function menu (){
	  get obmenu
}

  #conky
  function conk (){
	  get conky
	  sed -i '$a\\ conky &' /etc/skel/.config/openbox/autostart
      sed -i '$a\\ conky &' /root/.config/openbox/autostart
}
  
  #leafpad
  function leaf (){
	  get leafpad
}

  #geany
  function gean (){
	  get geany
}

  #abiword
  function abiw () {
	  get abiword
}

  #gnumeric
  function gnum () {
	  get gnumeric
}

  #xpdf
  function xpdf () {
	  get xpdf
}

  #firefox
  function fire (){
	  get firefox
}

  #chromium
  function chro (){
	  get chromium
}

  #midori
  function mido (){
	  get midori
}

  #gimp
  function gimp (){
	  get gimp
}

  #tint2
  function tint (){
	  get tint2
	  sed -i '$a\\ tint2 &' /etc/skel/.config/openbox/autostart
          sed -i '$a\\ tint2 &' /root/.config/openbox/autostart
}

  #mplayer
  function mpla () {
	  get mplayer
}

  #vlcl
  function vlcl () {
	  get vlc
}



#
# set infinite loop
#
while true
do
 
### display main menu ###
###ßûæ omg l'anti slash collé au commentaire fait bugguer le truc###
dialog --clear  --help-button --backtitle "postconfiguration openbox" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 15 50 4 \
instal "xorg openbox +startx" \
Exit "Exit to the shell" 2>"${INPUT}"
 
menuitem=$(<"${INPUT}")
 
 
# make decsion 
case $menuitem in
	instal) boxy;;
	Exit) echo "Bye"; break;;
esac
 
 # Install Login
  dialog --backtitle "postconfiguration openbox" --title "Session" \
  --ok-label "Valider" --cancel-label "Quitter" \
  --radiolist "Veuillez choisir le mode de connexion à votre session.\nSélection avec la barre d'espace." 20 70 3 \
  "lxdm" "lxdm, gestionnaire de connexion graphique" on \
  "stax" "startx lance openbox apres login" off 2> "${INPUT}"
  
CONNEXION=$(<"${INPUT}")
  
  case $CONNEXION in
  lxdm) lxdm ;;
  stax) stax ;;
  esac
  
  CONNEXION=$(<"${INPUT}")
  
  # Install File Manager
  dialog --backtitle "postconfiguration openbox" --title "Gestionnaire de fichiers" \
  --ok-label "Valider" --cancel-label "Quitter" \
  --radiolist "Installation de votre gestionnaire de fichiers préféré.\nSélection avec la barre d'espace." 20 70 2 \
  "thun" "Thunar, avec theme tango" on 2> "${INPUT}" 
  
  FILEMANAGER=$(<"${INPUT}")
  
  case $FILEMANAGER in
  thun) thun ;;
  esac
  
  
  # --checklist texte hauteur largeur hauteur-de-liste [ marqueur1 item1 état] ...
  dialog --backtitle "postconfiguration openbox" --title "audio" \
  --ok-label "Valider" --cancel-label "Quitter" \
  --checklist "le choix est predefinie, Cochez vos applications préférées avec la barre d'espace." 20 70 15 \
  "util" "alsal-utils acces a alsamixer" on \
  "gst0" "gstreamer librairie sons" on \
  "base" "gstreamer-plugins-base" on \
  "bad0" "gstreamer-plugins-bad" off \
  "ffmp" "gstreamer-plugins-ffmpeg" off \
  "good" "gstreamer-plugins-good " off \
  "pyth" "gstreamer-plugins-python " off \
  "ugly" "gstreamer-plugins-ugly" off \
  "gst1" "gstreamer1" off \
  "gsli" "gstreamer1-libav" off\
  "bas1" "gstreamer1-plugins-base" off \
  "bad1" "gstreamer1-plugins-bad" off \
  "liba" "gstreamer1-plugins-libav" off \
  "goo1" "gstreamer1-plugins-good" off \
  "ugl1" "gstreamer1-plugins-ugly" off 2> "${INPUT}"
    
  # traitement de la réponse
  for i in $(<"${INPUT}")
  do
  case $i in
  "util") util ;;
  "gst0") gst0 ;;
  "base") base ;;
  "bad0") bad0 ;;
  "ffmp") ffmp ;;
  "good") good ;;
  "pyth") pyth ;;
  "ugly") ugly ;;
  "gst1") gst1 ;;
  "gsli") gsli ;;
  "bas1") bas1 ;;
  "bad1") bad1 ;;
  "liba") liba ;;
  "goo1") goo1 ;;
  "ugl1") ugl1 ;;
  esac
  done
  
  # --checklist texte hauteur largeur hauteur-de-liste [ marqueur1 item1 état] ...
  dialog --backtitle "postconfiguration openbox" --title "tools et menu bureau" \
  --ok-label "Valider" --cancel-label "Quitter" \
  --checklist "Cochez vos applications préférées avec la barre d'espace." 20 70 15 \
  "wbar" "barre d'applications (seulement en 32bits)" off \
  "menu" "ob-menu gui pour gerer le menu openbox" on \
  "tint" "tint2 barre de tache" on \
  "conk" "conky moniteur system" off 2> "${INPUT}"
    
  # traitement de la réponse
  for i in $(<"${INPUT}")
  do
  case $i in
  "wbar") wbar ;;
  "menu") menu ;;
  "tint") tint ;;
  "conk") conk ;;
  "mpla") mpla ;;
  "vlcl") vlcl ;;
  esac
  done
 
  # Install utilitaire de conf
  
  # --checklist texte hauteur largeur hauteur-de-liste [ marqueur1 item1 état] ...
  dialog --backtitle "postconfiguration openbox" --title "Choix des applications" \
  --ok-label "Valider" --cancel-label "Quitter" \
  --checklist "Cochez vos applications préférées avec la barre d'espace." 20 70 15 \
  "leaf" "Leafpad, éditeur de texte " off \
  "gean" "geany editeur de txte " on \
  "abiw" "abiword editeur " on \
  "gnum" "gnumeric tableur " off \
  "xpdf" "Xpdf, suite d'outils pour PDF " off \
  "fire" "firefox naviguateur net" off \
  "chro" "chromium nav internet" off \
  "mido" "midori nav internet" off \
  "flas" "flash player -_-" off\
  "gimp" "editeur dessin" on \
  "mpla" "GNOME MPlayer, lecteur multimédia " on \
  "vlcl" "VLC, lecteur multimédia" off 2> "${INPUT}"
    
  # traitement de la réponse
  for i in $(<"${INPUT}")
  do
  case $i in
  "leaf") leaf ;;
  "gean") gean ;;
  "abiw") abiw ;;
  "gnum") gnum ;;
  "xpdf") xpdf ;;
  "fire") fire ;;
  "chro") chro ;;
  "mido") mido ;;
  "gimp") gimp ;;
  "mpla") mpla ;;
  "vlcl") vlcl ;;
  esac
  done
  
done
 
# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT