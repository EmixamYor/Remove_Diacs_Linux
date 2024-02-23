# Remove_Diacs_Linux
Remove diacs in a directory tree

```

## Nom :
        diacs_dirs_or_files.sh

## Synopsis :
        diacs_dirs_or_files.sh [REPERTOIRE]...

## Description :
        Programme qui, pour un repertoire passe en parametre,
        renomme tous les noms de fichiers et de repertoires
        incluant le repertoire passe en parametre et ce, pour
        toute l'arborescence de ce repertoire.
        Il remplacera :
          - Chaque signe diacritique par son caractere ASCII s'y
            rapprochant le plus.
          - Plusieurs caractères et tout espace par un '_'.
        Si a un meme endroit dans l'arborescence, 2 fichiers ou
        repertoires se nomme "AlphaNumérique" et "AlphàNumerique",
        le second qui sera renomme se fera ajouter un suffixe.

## Exemples d’utilisations :

        ./diacs_dirs_or_files.sh untitled\ folder/
        ./diacs_dirs_or_files.sh /home/user/Desktop/1234

```