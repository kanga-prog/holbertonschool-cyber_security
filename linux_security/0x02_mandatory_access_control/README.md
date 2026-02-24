# Linux Mandatory Access Control (MAC) – SELinux & AppArmor

## 📌 Description
Ce projet couvre les concepts fondamentaux de la sécurité Linux avancée, en particulier le **Mandatory Access Control (MAC)**, son implémentation via **SELinux** et **AppArmor**, ainsi que les outils et méthodes de gestion et de dépannage associés.

Il s’inscrit dans une démarche de **sécurité défensive**, de **durcissement système** et de **principe du moindre privilège**.

---

## 🎯 Objectifs pédagogiques
À la fin de ce projet, je suis capable d’expliquer :
- Le concept de **MAC** sous Linux
- Le fonctionnement de **SELinux**
- Les différences entre **SELinux et AppArmor**
- Le rôle des **politiques de sécurité**
- Le fonctionnement des **labels SELinux**
- Type Enforcement, RBAC, MLS et MCS
- La gestion et le diagnostic SELinux
- L’utilisation de **semanage**
- Le rôle des **logs d’audit**
- Le principe du **least privilege**

---

## 🛡️ Technologies abordées
- Linux Security Modules (LSM)
- SELinux
- AppArmor
- auditd
- semanage
- restorecon
- audit2allow

---

## 🔧 Commandes essentielles

### Vérifier SELinux
```bash
sestatus
getenforce
Gestion des contextes
semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
restorecon -Rv /web
Gestion des ports
semanage port -a -t http_port_t -p tcp 8080
Analyse des logs
ausearch -m AVC -i
sealert -a /var/log/audit/audit.log
📊 Comparaison MAC
SELinux	AppArmor
Basé sur labels	Basé sur chemins
Très sécurisé	Plus simple
Complexe	Accessible
RHEL / CentOS	Ubuntu
🧠 Concept clé

La sécurité ne repose pas sur la confiance, mais sur des règles imposées par le système.

📚 Références

NIST Glossary

Red Hat SELinux Documentation

Arch Linux Security Guide

Linux man-pages (semanage, auditd, ausearch)

👤 Auteur

kanga-prog
Cybersecurity / Linux Security
