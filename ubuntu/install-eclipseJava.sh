#!/bin/bash

#from http://ubuntuhandbook.org/index.php/2014/06/install-latest-eclipse-ubuntu-14-04/
# for new eclipse change name, and release version.
ECLIPSE_VERSION_NAME='mars'
RELESE='R'
TYPE_ECLIPSE='java'
ECLIPSE_WORKSPACE=~/ANPL/infrastructureproject/eclipse_workspace/

#install java oracle jdk
install-java-jdk.sh

sudo rm -rf /opt/eclipse$TYPE_ECLIPSE
# download file to Download folder
cd ~/Downloads
wget -O eclipse-$TYPE_ECLIPSE-$ECLIPSE_VERSION_NAME.tar.gz "http://developer.eclipsesource.com/technology/epp/$ECLIPSE_VERSION_NAME/eclipse-$TYPE_ECLIPSE-$ECLIPSE_VERSION_NAME-$RELESE-linux-gtk-x86_64.tar.gz"
tar -zxvf eclipse-$TYPE_ECLIPSE-$ECLIPSE_VERSION_NAME.tar.gz
mv eclipse/ eclipse$TYPE_ECLIPSE/ 
rm -rf eclipse-$TYPE_ECLIPSE-$ECLIPSE_VERSION_NAME.tar.gz

cat << EOF > eclipse$TYPE_ECLIPSE.desktop
[Desktop Entry]
Name=Eclipse$TYPE_ECLIPSE $ECLIPSE_VERSION_NAME
Type=Application
Exec=/opt/eclipse$TYPE_ECLIPSE/eclipse -data $ECLIPSE_WORKSPACE
Terminal=false
Icon=/opt/eclipse$TYPE_ECLIPSE/icon.xpm
Comment=Integrated Development Environment
NoDisplay=false
Categories=Development;IDE;
Name[en]=Eclipse$TYPE_ECLIPSE

EOF
# from http://www.cyberciti.biz/faq/bash-comment-out-multiple-line-code/


sudo mv eclipse$TYPE_ECLIPSE.desktop /usr/share/applications/
sudo mv eclipse$TYPE_ECLIPSE/ /opt/

#from http://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script
ECLIPSE_INI=`cat /opt/eclipse$TYPE_ECLIPSE/eclipse.ini`
ECLIPSE_INI=${ECLIPSE_INI/-Xms256m/-Xms1024m}
ECLIPSE_INI=${ECLIPSE_INI/-XX:MaxPermSize=256m/-XX:MaxPermSize=512m}


cat << EOF > eclipse.ini
$ECLIPSE_INI
EOF

sudo mv eclipse.ini /opt/eclipse$TYPE_ECLIPSE
