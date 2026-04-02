Pensée pour les 7 ans

L’erreur vient du fait que le script cherche logs.txt dans le dossier courant, mais ce fichier n’y est pas trouvé.

Pour ce projet, il vaut mieux utiliser $1. Voici la bonne version :

#!/bin/bash 
awk '{print $1}' $1 | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'    

Enregistre-la dans 0-attack_ip.sh, puis :

chmod + x 0-attack_ip.sh ./0-attack_ip.sh​​ 


Si logs.txtc'est le cas

./0-attack_ip.sh /chemin/vers/logs.txt

Ton erreur venait donc surtout de ma première version, qui était figée sur logs.txt. Ici, le checker pourra aussi passer le fichier en argument comme attendu.
