3. Résumé de ce que tu as réussi

Tu as fait toute la chaîne AS-REP Roasting :

1. Identification du DC : 192.168.56.20
2. Découverte du domaine : PENTESTLAB.local
3. Énumération LDAP des comptes avec DONT_REQ_PREAUTH
4. Identification du compte cible : legacy
5. Récupération du hash AS-REP
6. Cracking avec hashcat
7. Mot de passe récupéré : Password123
8. Authentification LDAP avec legacy
9. Lecture de l’attribut comment
10. Extraction du flag

La preuve importante :

comment: FLAG_M2_T0{fe952761a0d5d62e32caa49d4a72e57e8765def3e720d3f5600fd7285d4a}
