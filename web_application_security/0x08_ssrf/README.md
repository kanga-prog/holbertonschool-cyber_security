# 0x08. SSRF

## Description

Ce projet porte sur l'exploitation d'une vulnérabilité de type **Server-Side Request Forgery (SSRF)** sur la cible **Cyber - WebSec 0x08**.

L'objectif était d'exploiter la fonctionnalité **check reduction** de l'application **ShopAdmin** afin de forcer le serveur à effectuer une requête vers une ressource interne non accessible directement par l'utilisateur.

La vulnérabilité se trouvait dans le paramètre :

`articleApi`

L'application transmettait normalement la valeur suivante :

`http://internal-api.shop.com:3000/check-reduction`

En modifiant cette valeur, il a été possible d'utiliser le serveur comme relais pour accéder à l'interface d'administration interne.

## Objectif

Accéder au tableau de bord d'administration interne, puis récupérer le flag demandé dans le fichier :

`0-flag.txt`

## Méthodologie

La fonctionnalité vulnérable a été identifiée dans la route suivante :

`POST /check-reduction`

Le paramètre injectable était :

`articleApi`

Une première requête SSRF a permis d'accéder à l'interface d'administration locale :

`http://127.0.0.1:3000/admin`

Une seconde requête a permis d'accéder à la liste des éléments administratifs :

`http://127.0.0.1:3000/admin/list-of-items`

C'est dans cette page que le flag a été retrouvé.

## Flag

`4e98c4f758935825f997d17ed249b80e`

## Fichier attendu

Le fichier `0-flag.txt` doit contenir exactement :

`4e98c4f758935825f997d17ed249b80e`

avec un saut de ligne final.

## Notions retenues

- Comprendre le principe d'une SSRF
- Identifier un paramètre serveur qui récupère une URL
- Exploiter un accès à des ressources internes via `127.0.0.1`
- Prendre en compte le port exposé dans un environnement port-forwarded
- Parcourir des routes internes pour extraire une information sensible
