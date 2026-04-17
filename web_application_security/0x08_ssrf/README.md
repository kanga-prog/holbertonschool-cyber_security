# 0x08. SSRF

## Description

Ce projet porte sur l’exploitation de vulnérabilités de type **Server-Side Request Forgery (SSRF)** au sein de l’application **ShopAdmin** sur la cible `web0x08.hbtn`.

L’objectif global est de comprendre comment une application côté serveur peut être forcée à effectuer des requêtes non prévues vers des ressources internes, puis de contourner progressivement les mécanismes de défense mis en place au fil des niveaux.

Chaque tâche repose sur la même logique métier : une fonctionnalité de type **Check Reduction / Check Discount** utilise un paramètre contrôlable par l’utilisateur (`articleApi`) pour interroger une URL côté serveur. En manipulant cette valeur, il est possible d’amener le serveur à interagir avec des ressources internes protégées, notamment une interface d’administration.

---

## Objectifs pédagogiques

À la fin de ce projet, il faut être capable de :

- expliquer ce qu’est une SSRF ;
- comprendre comment une SSRF fonctionne ;
- identifier un paramètre vulnérable côté serveur ;
- exploiter une SSRF simple ;
- contourner des filtrages basés sur le hostname ;
- contourner des contrôles via représentation décimale de localhost ;
- contourner des protections via open redirect ;
- comprendre l’impact des ports, des redirections et des services backend internes.

---

## Environnement

- **Cible** : `web0x08.hbtn`
- **Contexte** : Web Application Security / SSRF
- **Outils utilisés** :
  - navigateur web
  - Burp Suite
  - curl
- **Système de test** : Kali Linux

---

## Principe général d’exploitation

Dans chaque niveau, la vulnérabilité se situe dans un paramètre similaire à :

```text
articleApi=http://...

L’application transmet cette URL à son backend, qui effectue ensuite une requête serveur vers la destination indiquée.

L’exploitation consiste à remplacer cette URL par une autre cible afin de faire accéder le serveur à une ressource normalement non accessible directement, par exemple :

un dashboard d’administration ;
une route interne ;
une API interne ;
une ressource locale sur localhost, 127.0.0.1 ou équivalent ;
une URL interne atteinte via redirection ouverte.
Tâches réalisées
Task 0 — SSRF simple

Application : http://web0x08.hbtn/
Port interne important : 3000

Une SSRF simple a été exploitée dans la fonctionnalité check reduction via le paramètre articleApi.

Le serveur a pu être forcé à accéder à l’interface d’administration locale avec :

http://127.0.0.1:3000/admin

Puis à la liste des éléments administratifs avec :

http://127.0.0.1:3000/admin/list-of-items

Le flag a été récupéré depuis cette page.

FLAG_0
4e98c4f758935825f997d17ed249b80e

Task 1 — Bypass via représentation décimale de localhost

Application : http://web0x08.hbtn/app2/
Port interne important : 3001

Ce niveau ajoutait un filtrage bloquant les formes classiques de localhost et 127.0.0.1.

Le contournement a consisté à utiliser la représentation décimale de 127.0.0.1 :

2130706433

Le payload gagnant a été :

http://2130706433:3001/admin/list-of-items

FLAG_1
3cb16638446a7b860e3dc6473a106472

Task 2 — Bypass d’allowlist avec whitelist filter

Application : http://web0x08.hbtn/app3/
Port interne important : 3002

Ce niveau introduisait un filtrage plus strict basé sur une whitelist du hostname.

L’hôte autorisé observé dans le formulaire était :

discount.newshop.tn

Le contournement a été réalisé avec un payload de type :

http://localhost:3002%2523@discount.newshop.tn:3002/admin/list-of-items

Cette technique permet de tromper la validation du hostname tout en provoquant un accès à la cible locale.

FLAG_2
2f3e221b5a571d31cffaf39c84f8e7ac

Task 3 — Exploitation via open redirect

Application : http://web0x08.hbtn/app4-1/
Port interne important : 8080

Ce niveau introduisait une nouvelle fonctionnalité de navigation produit utilisant une route de redirection :

/product/nextProduct?path=...

Le paramètre articleApi ne pouvait plus être utilisé directement avec des hostnames arbitraires sans déclencher des protections. La résolution a consisté à utiliser la fonctionnalité de redirection comme pivot pour faire suivre au backend une redirection vers l’interface d’administration interne.

Le payload gagnant a été :

http://web0x08.hbtn:8080/product/nextProduct?path=http://127.0.0.1:8080/admin

Encodé dans la requête POST vers /app4-1/check-discount, il a permis de déclencher la réussite du niveau et d’obtenir le flag.

FLAG_3
ac97a90dd4036c4c5a8d4bdad4b818a3

Résumé des flags
Task	Flag
0	4e98c4f758935825f997d17ed249b80e
1	3cb16638446a7b860e3dc6473a106472
2	2f3e221b5a571d31cffaf39c84f8e7ac
3	ac97a90dd4036c4c5a8d4bdad4b818a3
Enseignements clés

Ce projet montre qu’une SSRF peut évoluer de manière progressive :

d’une exploitation simple vers 127.0.0.1 ;
vers le contournement de blacklist par représentation alternative ;
puis vers le contournement d’allowlist via des techniques de parsing d’URL ;
enfin vers une exploitation indirecte par open redirect.

Il met également en évidence l’importance :

de restreindre strictement les destinations autorisées ;
de ne pas faire confiance à des URL construites ou modifiées côté utilisateur ;
de désactiver ou contrôler les redirections ;
d’isoler les services internes ;
de protéger les routes d’administration indépendamment de leur exposition réseau.
Fichiers attendus
0-flag.txt
1-flag.txt
2-flag.txt
3-flag.txt

Chaque fichier doit contenir exactement une seule ligne avec le flag correspondant, suivie d’un saut de ligne final.

Auteur

Projet réalisé dans le cadre du repository :

holbertonschool-cyber_security

Dossier :

web_application_security/0x08_ssrf
