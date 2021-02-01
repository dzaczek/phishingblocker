#!/bin/bash
#version  0.1

HEADER1='#Do not add after this line'
HOSTP="/etc/hosts"
FOOTER1="#End of auto def"

_CLEAN_HOST_FILE() {
# sed -i.bak   '/'"$HEADER1"'/,$d' "${HOSTP}"
 #sed -n  '1,/'"$HEADER1"'/p;/'"$FOOTER1"'/,$p' "${HOSTP}"
 sed -i.bakn  '/'"$HEADER1"'/,/'"$FOOTER1"'/d' "${HOSTP}"
}

_ADD_HEADER() {
echo ${HEADER1} >> ${HOSTP}
}

_ADD_FOOTER() {
echo ${FOOTER1} >> ${HOSTP}
}

_SOURCE_CERTPL_hosts(){
#http://hole.cert.pl/domains/domains_hosts.txt
curl -s   http://hole.cert.pl/domains/domains_hosts.txt   |  grep -E  "([0-9]{1,3}[\.]){3}[0-9]{1,3}\s\S+" >> ${HOSTP}
#echo "TEST $(date) " >> ${HOSTP}
}

_SOURCE_GITHUB_MITC(){
#https://github.com/mitchellkrogza/Phishing.Database
wget  -qO- https://raw.githubusercontent.com/mitchellkrogza/Phishing.Database/master/ALL-phishing-domains.tar.gz |  tar -xvzO - 2>/dev/null | sed '1d'  | sed  's/^/195.187.6.34\ /g' >> ${HOSTP} 
}


_CLEAN_HOST_FILE
_ADD_HEADER
_SOURCE_CERTPL_hosts
_SOURCE_GITHUB_MITC
_ADD_FOOTER
#cat $HOSTP 


