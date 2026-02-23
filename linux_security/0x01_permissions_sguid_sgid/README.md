# Permissions, SUID & SGID

## 📌 Description du projet

Ce projet a pour objectif de maîtriser les **permissions Linux**, la **gestion des utilisateurs et des groupes**, ainsi que les **bits spéciaux de sécurité** (SUID, SGID, Sticky bit).  
À travers des scripts Bash courts et précis, ce projet aborde des cas **réalistes d’administration système et de cybersécurité**.

Tous les scripts sont testés sur **Kali Linux** et respectent les contraintes imposées par Holberton School.

---

## 🎯 Objectifs pédagogiques

À la fin de ce projet, vous serez capable d’expliquer :

- Les **trois groupes de permissions Linux** (user, group, others)
- L’utilisation des commandes :
  - `chmod`
  - `sudo`
  - `su`
  - `chown`
  - `chgrp`
- Le rôle des bits **SUID** et **SGID**
- La différence entre **chmod**, **umask**, **chown** et **chgrp**
- Les bonnes pratiques de gestion des permissions
- Comment **auditer et détecter des fichiers dangereux** (SUID / SGID)
- Le fonctionnement et l’utilité du **umask**

---

## ⚙️ Contraintes générales

- Éditeurs autorisés : `vi`, `vim`, `emacs`
- Scripts testés sur **Kali Linux**
- Tous les fichiers :
  - commencent par `#!/bin/bash`
  - se terminent par une nouvelle ligne
  - sont exécutables
- Longueur des scripts limitée (2 à 4 lignes selon l’exercice)
- Interdiction d’utiliser :
  - `echo` (dans certains exercices)
  - `printf`
  - backticks `` ` ``
  - `&&` et `||`
- Respect du style **Betty**

---

## 📂 Contenu du projet

| Fichier | Description |
|------|------------|
| `0-add_user.sh` | Crée un utilisateur et définit son mot de passe |
| `1-add_group.sh` | Crée un groupe, change le groupe propriétaire d’un fichier et définit les permissions |
| `2-sudo_nopass.sh` | Autorise un utilisateur à utiliser sudo sans mot de passe |
| `3-find_files.sh` | Recherche les fichiers avec le bit SUID activé |
| `4-find_suid.sh` | Liste les fichiers SUID dans un répertoire donné |
| `5-find_sgid.sh` | Liste les fichiers SGID dans un répertoire donné |
| `6-check_files.sh` | Trouve les fichiers SUID/SGID modifiés récemment |
| `7-file_read.sh` | Rend les fichiers lisibles uniquement pour les autres utilisateurs |
| `8-change_user.sh` | Change le propriétaire de fichiers si l’ancien propriétaire est user2 |
| `9-empty_file.sh` | Donne toutes les permissions aux fichiers vides |

---

## 🔐 Sécurité et bonnes pratiques

Ce projet met en évidence :
- Les **risques liés aux fichiers SUID/SGID**
- L’importance du **principe du moindre privilège**
- Les dangers des permissions trop permissives (`777`)
- L’utilisation responsable de `sudo` et des fichiers `/etc/sudoers.d`

---

## 🧪 Exemple d’exécution

```bash
sudo ./3-find_files.sh /usr/bin
