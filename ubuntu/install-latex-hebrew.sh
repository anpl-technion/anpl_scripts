DPARTY=~/ANPL/code/3rdparty

sudo apt-get install texstudio texlive-lang-hebrew texlive-bibtex-extra -y

mkdir -p $DPARTY
rm -rf $DPARTY/culmus-latex-*
cd ~/Downloads
wget -O culmus-latex.tar.gz  "http://netix.dl.sourceforge.net/project/ivritex/culmus-latex/culmus-latex-0.7/culmus-latex-0.7-r1.tar.gz"
tar xvzf culmus-latex.tar.gz
mv culmus-latex-* $DPARTY
rm -rf culmus-latex.tar.gz
cd $DPARTY/culmus-latex-*
sudo make
sudo make install
