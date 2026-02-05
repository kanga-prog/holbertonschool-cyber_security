# 🧪 Web Application Security – SQL & NoSQL Injection

Ce projet fait partie du cursus **Holberton School – Cyber Security** et se concentre sur l’exploitation des vulnérabilités **SQL Injection** et **NoSQL Injection** dans une application web volontairement vulnérable.

L’objectif global est de comprendre :

* comment naissent ces vulnérabilités,
* comment les exploiter méthodiquement,
* et comment un attaquant peut aller du simple contournement d’authentification jusqu’à une exploitation logique avancée (profit, escalade, manipulation métier).

---

## 📂 Structure du projet

```
web_application_security/
└── 0x03_sql_nosql_injection/
    ├── 0-*.txt
    ├── 1-*.txt
    ├── ...
    └── 7-flag.txt
```

Chaque tâche correspond à une étape précise d’exploitation.

---

## 🎯 Objectifs pédagogiques

À travers ces tâches, vous apprendrez à :

* Comprendre la différence entre **SQLi** et **NoSQLi**
* Exploiter une **injection de second ordre**
* Contourner un mécanisme d’authentification
* Énumérer des utilisateurs via des opérateurs NoSQL
* Exploiter une logique métier vulnérable (crypto exchange)
* Chaîner plusieurs failles pour atteindre un objectif final

---

## 🧩 Tâches principales

### 🔐 1. SQL Injection – Second Order Injection

* Création d’utilisateurs avec des charges utiles stockées (`{{7*7}}`)
* Exploitation lors d’un affichage ultérieur
* Mise en évidence des risques liés à la **réutilisation de données non filtrées**

👉 Vulnérabilité : *Second Order SQL Injection / Template Injection*

---

### 🔓 2. NoSQL Injection – Bypass Login

L’application utilise une base **NoSQL (MongoDB)** pour l’authentification.

La requête backend vulnérable ressemble à :

```js
db.users.findOne({
  username: req.body.username,
  password: req.body.password
})
```

En injectant des opérateurs NoSQL, il est possible de modifier la logique de la requête.

#### Exemple de bypass :

```json
{
  "username": { "$ne": null },
  "password": { "$ne": null }
}
```

✔️ Connexion réussie sans connaître d’identifiants valides.

---

### 🧠 3. Compréhension des opérateurs NoSQL

Les opérateurs clés utilisés :

| Opérateur | Description          | Utilisation             |
| --------- | -------------------- | ----------------------- |
| `$ne`     | différent de         | bypass login            |
| `$exists` | champ présent        | énumération             |
| `$gte`    | supérieur ou égal    | trouver un compte riche |
| `$regex`  | expression régulière | deviner usernames       |

---

### 🔍 4. NoSQL Injection – Énumération des utilisateurs

L’objectif ici est d’identifier des profils utilisateurs intéressants.

#### Techniques utilisées :

* Tests par regex :

```json
{ "username": { "$regex": "^a" }, "password": { "$ne": null } }
```

* Sondage logique via les réponses de l’application (succès / erreur)
* Déduction indirecte de la présence d’utilisateurs

⚠️ Le backend retourne souvent **le même message de succès**, ce qui empêche une énumération directe mais confirme l’existence de profils.

---

### 💰 5. NoSQL Injection – Enumerating for Profit

Objectif final :

> Trouver un compte avec suffisamment de balance pour acheter **≥ 1 HBTNc**.

#### Stratégie attendue :

1. Bypass login via NoSQLi
2. Identifier un utilisateur ayant un champ `balance`
3. Accéder aux endpoints protégés (coins, market, exchange)
4. Exploiter la logique métier pour effectuer un échange valide

Le **FLAG final** n’apparaît **qu’après l’achat effectif de 1 HBTNc ou plus**.

---

## 🔐 Points de sécurité mis en évidence

* Absence de validation des entrées utilisateur
* Confiance excessive dans la structure JSON reçue
* Mélange logique métier / authentification
* Manque de contrôles d’autorisation côté serveur

---

## 🛡️ Bonnes pratiques (défensif)

Pour éviter ces vulnérabilités en production :

* Valider strictement les types (`string`, pas `object`)
* Interdire les opérateurs MongoDB côté input utilisateur
* Utiliser des schémas stricts (Joi, Mongoose strict)
* Séparer authentification et logique métier
* Journaliser les tentatives anormales

---

## ⚠️ Avertissement

Les techniques présentées dans ce projet sont **strictement éducatives**.

Elles doivent être utilisées **uniquement** :

* dans un environnement de test,
* avec autorisation explicite,
* dans un cadre légal et professionnel.

Toute utilisation abusive dans un contexte réel est illégale.

---

## 🏁 Conclusion

Ce laboratoire illustre parfaitement comment une simple faille d’injection NoSQL peut évoluer :

➡️ bypass d’authentification → énumération → exploitation métier → gain final.

Une excellente démonstration de l’importance d’une **validation stricte des entrées** et d’une **séparation claire des responsabilités côté backend**.

🚀

