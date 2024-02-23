# Remove_Diacs_Linux
Remove diacs in a directory tree

```

 Nom :
        diacs_dirs_or_files.sh

 Synopsis :
        diacs_dirs_or_files.sh [REPERTOIRE]...

 Description :
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

 Exemples d’utilisations :

        ./diacs_dirs_or_files.sh untitled\ folder/
        ./diacs_dirs_or_files.sh /home/user/Desktop/1234

----

 Name :
        diacs_dirs_or_files.sh

 Synopsis :
        diacs_dirs_or_files.sh [DIRECTORY]...

 Description :
        Program which, for a directory passed as a parameter,
        renames all file and directory names
        including the parameterized directory, for
        the entire directory tree.
        It will replace :
          - Each diacritical mark by its closest ASCII character.
          - Some other characters and spaces with a '_'.
        If at the same location in the tree, 2 files or
        directories are called "AlphaNumérique" and "AlphàNumerique",
        the second to be renamed will have a suffix added.

 Examples of uses :

        ./diacs_dirs_or_files.sh untitled\ folder/
        ./diacs_dirs_or_files.sh /home/user/Desktop/1234

```