Le problème vient de ton fichier 0-main.rb : il charge seulement la fonction, mais il ne l’appelle pas.

Actuellement tu as :

require_relative '0-hello_world_function'

Il faut ajouter l’appel :

require_relative '0-hello_world_function'

say_hello("Ruby!")

Puis relance :

ruby 0-main.rb

Résultat attendu :

Hello, Holberton! from Ruby!

Tu peux modifier avec :

vim 0-main.rb

ou plus rapide :

cat > 0-main.rb
require_relative '0-hello_world_function'

say_hello("Ruby!")

Puis appuie sur CTRL + D.
