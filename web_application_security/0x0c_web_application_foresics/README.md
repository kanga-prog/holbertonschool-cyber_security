Je vais t’aider à identifier pourquoi ton script n’affiche rien, puis je te donnerai la bonne façon d’utiliser auth.log et dmesg.

Thought for 45s

Le problème vient très probablement de la façon dont tu exécutes le script.

Pourquoi tu n’as rien

Dans les requirements, il y a ceci :

Ensure that $1 is used without quotes in your script

Ça veut dire que ton script doit prendre un fichier en argument.

Donc si tu l’exécutes comme ça :

./0-service.sh

alors $1 est vide.

Résultat :

soit ton script ne lit rien,
soit il attend une entrée,
soit il termine sans affichage.
Ce qu’il faut comprendre sur auth.log et dmesg

Dans ce projet, les fichiers fournis sont :

auth.log → logs d’authentification
C’est ici qu’on voit généralement :
sshd
pam_unix
Failed password
Accepted password
Invalid user
dmesg → messages du noyau Linux
C’est utile pour d’autres analyses, mais pas pour identifier ici le service d’accès utilisé par les attaquants dans ce task 0.

Donc pour Attacker Service, le bon fichier à utiliser est surtout :

auth.log
Comment utiliser les fichiers

Tu dois lancer ton script avec le fichier en argument :

./0-service.sh auth.log

et éventuellement pour tester l’autre :

./0-service.sh dmesg

Mais pour cette question, c’est auth.log qui est pertinent.

Comment vérifier manuellement avant le script

Fais déjà ceci :

head auth.log

ou :

grep -i ssh auth.log | head

ou encore :

grep 'pam_unix' auth.log | head

Tu verras normalement des lignes liées à :

pam_unix(sshd:auth):
pam_unix(sshd:session):
Failed password
Accepted password
Invalid user

Donc le service utilisé est bien :

sshd

Script correct pour ce task

Voici un script simple, conforme à l’idée du sample, qui compte les éléments du log :

#!/bin/bash
grep -oE '[[:alnum:]_().:-]+' $1 2>/dev/null | sort | uniq -c | sort -nr
Pourquoi ce script marche

Il fait ceci :

grep -oE ... $1 → extrait les mots/tokens du fichier donné en argument
sort → trie
uniq -c → compte
sort -nr → affiche du plus fréquent au moins fréquent

Si tu l’exécutes avec :

./0-service.sh auth.log

tu devrais obtenir quelque chose de très proche de :

34806 pam_unix(sshd:auth):
20339 Failed
14478 Invalid
...
Si tu veux exactement repérer le service

Tu peux aussi tester directement :

grep -oE 'pam_unix\([^)]+\):' auth.log | sort | uniq -c | sort -nr

Ça te donnera quelque chose comme :

34806 pam_unix(sshd:auth):
200 pam_unix(sshd:session):

Et là, on voit clairement que le service est :

sshd
