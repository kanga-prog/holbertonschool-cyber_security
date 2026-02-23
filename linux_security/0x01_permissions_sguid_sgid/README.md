# Permissions, SUID & SGID

## 📌 Description du projet

Ce projet a pour objectif de maîtriser les **permissions Linux**, la **gestion des utilisateurs et des groupes**, ainsi que les mécanismes de sécurité avancés comme **SUID, SGID et Umask**.

Il s’inscrit dans un contexte **cybersécurité / administration système**, où la compréhension fine des droits d’accès est essentielle pour sécuriser un système Linux multi‑utilisateur.

---

## 🎯 Objectifs pédagogiques

À la fin de ce projet, je suis capable d’expliquer sans aide externe :

* Les **trois groupes de permissions Linux** : user, group et others
* L’utilité des commandes suivantes :

  * `chmod`
  * `sudo`
  * `su`
  * `chown`
  * `chgrp`
* Le rôle et l’utilisation des **bits spéciaux SUID et SGID**
* La différence entre `chown` et `chgrp`
* Les **bonnes pratiques** de gestion des permissions sous Linux
* Les méthodes pour **auditer les permissions** d’un système
* Le fonctionnement et l’utilité de **umask**

---

## ⚙️ Contraintes techniques

* Éditeurs autorisés : `vi`, `vim`, `emacs`
* Scripts testés sur **Kali Linux**
* Tous les fichiers doivent :

  * commencer par `#!/bin/bash`
  * se terminer par une **ligne vide**
  * être **exécutables**
* Interdictions :

  * backticks `` ` ``
  * opérateurs `&&` et `||`
  * `printf`
* Style de code conforme à **Betty**

---

## 📂 Structure du projet

```text
linux_security/0x01_permissions_sguid_sgid/
│
├── README.md
└── 0-add_user.sh
```

---

## 🧪 Tâche 0 – Who can add a new user in Linux!

### 📄 Description

Écrire un script Bash qui :

* crée un nouvel utilisateur Linux
* définit un mot de passe pour cet utilisateur

Le script doit :

* prendre le **nom d’utilisateur** en argument `$1`
* prendre le **mot de passe** en argument `$2`

---

## 📜 Script : `0-add_user.sh`

```bash
#!/bin/bash
useradd "$1"
echo "$1:$2" | chpasswd
```

---

## ▶️ Utilisation

Rendre le script exécutable :

```bash
chmod +x 0-add_user.sh
```

Exécuter le script avec les privilèges root :

```bash
sudo ./0-add_user.sh holberton 'H@ck$@f3Gu@rD!'
```

---

## 🔍 Vérifications

Vérifier la création de l’utilisateur :

```bash
tail -1 /etc/passwd
```

Vérifier la création du mot de passe :

```bash
sudo tail -1 /etc/shadow
```

---

## 🔐 Sécurité et bonnes pratiques

* L’utilisation de `sudo` est obligatoire pour la gestion des utilisateurs
* Les mots de passe ne sont jamais stockés en clair
* Les permissions doivent toujours être **restrictives par défaut**
* L’usage de **umask**, des groupes et de SGID est recommandé pour les environnements collaboratifs

---

## 🧠 Conclusion

Ce projet renforce les bases essentielles de la **sécurité Linux**, indispensables en administration système et en cybersécurité. Il met en pratique la gestion des utilisateurs, des permissions et des mécanismes de protection intégrés au système.

---

✅ Projet réalisé dans le cadre de **Holberton School – Cyber Security**

