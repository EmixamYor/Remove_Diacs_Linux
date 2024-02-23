#!/bin/bash
#
#####################
##### Variables #####
#####################
declare dir=    # Repertoire passe en parametre
declare file=   # Chaque repertoire ou fichier d'origine (lu par la commande "find")
declare d=      # Le repertoire absolu de $file
declare f=      # Le nom de base de $file (sans le repertoire absolu)
declare new=    # La nouvelle valeur de $f apres le filtrage des diacs
declare i=      # Le nombre de fichiers/repertoires traites
declare now=    # La date et l'heure pour nommer le fichier .log
declare suffix= # Sera renomme avec cette valeur si existe deja
declare depth=  # Valeur de la profondeur du sujet dans l'arborescence spécifie en parametre
declare newdepth= # Valeur pour comparer la profondeur d'un nouveau sujet avant de reinitialiser le compteur du suffixe
declare boolsuffix= # While loop ; Incrementation de la valeur su suffixe
#####################
##### Functions #####
#####################
function HELP () { echo -e "\n`REPEAT "∋" 33``REPEAT "∈" 33`\n
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

\n`REPEAT "∋" 33``REPEAT "∈" 33`\n"; }
function REPEAT () { local str=$1; local num=$2; python -c "print ( '$str' * $num ) "; }
function repeat () { local str=$(printf "%${2}s"); printf %s "${str// /$1}"; }
function CLEAN () {
  local VAR="`basename -- "$1"`"
  local CLEAR=`echo $VAR | sed \
    -e 'y/áâãāăąǎǟǡȁȃȧᶏḁạảấầẩẫậắằẳẵặǻåäà/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/' \
    -e 'y/ÀÁÂÃĀĂĄǍǞǠȀȂȦȺɑΆάαᴀḀẠÄẢẤẦẨẪẬẮẰẲẴẶἀἁἂἃἄἅἆἇἈἉἊἋἌἍἎἏὰάᾀᾁᾂᾃᾄᾅᾆᾇᾈᾉᾊᾋᾌᾍᾎᾏᾰᾱᾲᾳᾴᾶᾷᾸᾹᾺΆᾼ/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/' \
    -e 'y/ƀƃɓᵬᶀḃḅḇ/bbbbbbbb/' \
    -e 'y/ƁƂɃʙβϐᴃᵦḂḄḆ/BBBBBBBBBBB/' \
    -e 'y/¢ćĉċčƈȼɕḉ￠ç/ccccccccccc/' \
    -e 'y/©ĆĈĊČƇȻʗᴄḈÇ/CCCCCCCCCCC/' \
    -e 'y/ðďđƌȡɖɗᵭᶁᶑḋḍḏḑḓ/ddddddddddddddd/' \
    -e 'y/ÐĎĐƉƊƋᴅᴆḊḌḎḐḒ/DDDDDDDDDDDDD/' \
    -e 'y/êëēĕėèęěéȅȇȩɇᶒḕḗḙḛḝẹẻẽếềểễệ/eeeeeeeeeeeeeeeeeeeeeeeeeee/' \
    -e 'y/ÈÊËÉĒĔĖĘĚȄȆȨɆΈέεᴇḔḖḘḚḜẸẺẼẾỀỂỄỆἐἑἒἓἔἕἘἙἚἛἜἝὲέῈΈ/EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE/' \
    -e 'y/ƒᵮᶂḟ/ffff/' \
    -e 'y/ƑḞ/FF/' \
    -e 'y/ĝğġģǥǧǵɠɡᶃḡ/ggggggggggg/' \
    -e 'y/ĜĞĠĢƓǤǦǴɢʛḠ/GGGGGGGGGGG/' \
    -e 'y/ĥħȟɦḣḥḧḩḫẖ/hhhhhhhhhh/' \
    -e 'y/ĤĦȞʜΉήηḢḤḦḨḪἠἡἢἣἤἥἦἧἨἩἪἫἬἭἮἯὴήᾐᾑᾒᾓᾔᾕᾖᾗᾘᾙᾚᾛᾜᾝᾞᾟῂῃῄῆῇῊΉῌ/HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH/' \
    -e 'y/íîïìĩīĭįıǐȉȋɨᵢᶖḭḯỉị/iiiiiiiiiiiiiiiiiii/' \
    -e 'y/ÌÍÎÏĨĪĬĮİƖƗǏȈȊɩɪΊΐΪίιϊᵻḬḮỈỊἰἱἲἳἴἵἶἷἸἹἺἻἼἽἾἿὶίῐῑῒΐῖῗῘῙῚΊ/IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII/' \
    -e 'y/ĵǰȷɉɟʄʝ/jjjjjjj/' \
    -e 'y/ĴɈᴊ/JJJ/' \
    -e 'y/ķĸƙǩᶄḱḳḵ/kkkkkkkk/' \
    -e 'y/ĶƘǨκϰᴋḰḲḴ/KKKKKKKKK/' \
    -e 'y/ĺļľŀłƚȴɫɬɭᶅḷḹḻḽ/lllllllllllllll/' \
    -e 'y/ĹĻĽĿŁȽʟᴌḶḸḺḼ/LLLLLLLLLLLL/' \
    -e 'y/ɱᵯᶆḿṁṃ/mmmmmm/' \
    -e 'y/µᴍḾṀṂ/MMMMM/' \
    -e 'y/ńņňŉƞǹȠȵɲɳᵰᶇṅṇṉṋ/nnnnnnnnnnnnnnnn/' \
    -e 'y/ŃŅŇƝǸɴνṄṆṈṊ/NNNNNNNNNNN/' \
    -e 'y/óôòöõōŏőơǒǫǭȍȏȫȭȯȱɵṍṏṑṓọỏốồổỗộớờởỡợ/ooooooooooooooooooooooooooooooooooo/' \
    -e 'y/ÒÓÔÖÕŌŎŐƟƠǑǪǬȌȎȪȬȮȰΌοόᴏṌṎṐṒỌỎỐỒỔỖỘỚỜỞỠỢὀὁὂὃὄὅὈὉὊὋὌὍὸόῸΌ/OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO/' \
    -e 'y/ƥᵱᵽᶈṕṗ/pppppp/' \
    -e 'y/ƤρϱϼᴘᴩᵨṔṖῤῥῬ/PPPPPPPPPPPP/' \
    -e 'y/ɋʠ/qq/' \
    -e 'y/Ɋ/Q/' \
    -e 'y/ŕŗřȑȓɍɼɽɾᵣᵲᵳᶉṙṛṝṟ/rrrrrrrrrrrrrrrrr/' \
    -e 'y/®ŔŖŘȐȒɌʀṘṚṜṞ/RRRRRRRRRRRR/' \
    -e 'y/śŝşšșȿʂᵴᶊṡṣṥṧṩ/ssssssssssssss/' \
    -e 'y/ŚŜŞŠȘṠṢṤṦṨ/SSSSSSSSSS/' \
    -e 'y/ţťŧƫƭțȶʈᵵṫṭṯṱẗ/tttttttttttttt/' \
    -e 'y/ŢŤŦƬƮȚȾτᴛṪṬṮṰ/TTTTTTTTTTTTT/' \
    -e 'y/úûũūüùŭůűųưǔǖǘǚǜȕȗʉᵤᶙṳṵṷṹṻụủứừửữự/uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu/' \
    -e 'y/ÙÚÛÜŨŪŬŮŰŲƯǓǕǗǙǛȔȖɄᴜᵾṲṴṶṸṺỤỦỨỪỬỮỰ/UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU/' \
    -e 'y/ʋᵥᶌṽṿ/vvvvv/' \
    -e 'y/ƲᴠṼṾ/VVVV/' \
    -e 'y/ŵẁẃẅẇẉẘ/wwwwwww/' \
    -e 'y/ŴᴡẀẂẄẆẈ/WWWWWWW/' \
    -e 'y/ᶍẋẍ/xxx/' \
    -e 'y/χᵪẊẌ/XXXX/' \
    -e 'y/ýÿŷƴȳɏẏẙỳỵỷỹỿ/yyyyyyyyyyyyy/' \
    -e 'y/ÝŶŸƱƳȲɎʊʏΎΫΰυϋύϒϓϔẎỲỴỶỸỾὐὑὒὓὔὕὖὗὙὛὝὟὺύῠῡῢΰῦῧῨῩῪΎ/YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY/' \
    -e 'y/źżžƶȥɀʐʑᵶᶎẑẓẕ/zzzzzzzzzzzzz/' \
    -e 'y/ŹŻŽƵȤζᴢẐẒẔ/ZZZZZZZZZZ/' \
    -e 'y=\/=_=' \
    -e 'y=\\\=_=' \
    -e 'y=\|=_=' \
    -e 'y=\"=_=' \
    -e "y=\'=_=" \
    -e 'y=\`=_=' \
    -e 'y=\()=__=' \
    -e "y/—#%?&*±+$＄¯´@£¤¬!¦§☻²³¼½¾ⱥꜳꜹꜻ=~{}[]<>:;^¨, ­¶°∕«»’/__________________________________________________/"`
  # Apres le filtrage de $CLEAR, substituer tout ce qui n'est pas AlphaNumerique, ".", "-" et "_" par "_"
  local CLEARED=`echo "${CLEAR//[^a-zA-Z0-9\.\_\-]/_}"`
  echo "$CLEARED"
}
################
##### Code #####
################
#
# Si le parametre est un repertoire, creation de la valeur "dir"
if [[ -d "${1}" ]]; then
	dir="${1}"
	# Si le dernier caractere de la valeur est different de "/", ajout de "/"
	if [ "${dir: -1}" != "/" ]; then
		dir=$dir"/"
	fi
	now="$(date '+%Y-%m-%d_-_%H:%M:%S')"
	# Filtrer/Renommer chaque repertoire et fichier en commencant par le plus eloigne
	while IFS= read -r -d '' file; do
		d="$( dirname "$file" )"
		f="$( basename "$file" )"
		new=`CLEAN "$f"`
		depth=`echo "$file" | grep -o '/' - | wc -l`
		boolsuffix=false
		if [ "$depth" != "$newdepth" ]; then
			suffix=0
		fi
		((i++))
		if [ "$f" != "$new" ]; then
			echo -e "\nOriginal PATH is : $d/$f\n" >> Diacs_$now.log
			if [ -e "$file" ]; then
				if [ -e "$d/$new" ]; then
					while [[ $boolsuffix != true ]]; do
						((suffix++))
						if [ ! -e "$d/$new"_"$suffix" ]; then
							boolsuffix=true
						fi
					done
					echo -e "\nSUFFIX = $suffix\n" >> Diacs_$now.log
					echo -e "`repeat ">" 33``repeat "<" 33`\n" >> Diacs_$now.log
					echo -e "Existe -- Le suffixe $suffix a ete ajoute\n  --> $f\n"­­­­"  --> $new"_"$suffix" >> Diacs_$now.log
					echo -e "\n`repeat ">" 33``repeat "<" 33`\n" >> Diacs_$now.log
					mv "$file" "$d/$new"_"$suffix"
				else
					echo "$f"­­­­$'\n'"$new"$'\n' >> Diacs_$now.log
					mv "$file" "$d/$new"
				fi
			fi
		elif [ "$f" == "$new" ]; then
			:
		fi
		newdepth=$depth
	done < <(find "$dir" -depth -print0)
	echo -e "\n`repeat "∋" 33``repeat "∈" 33`\n" | tee -a Diacs_$now.log
	echo -e "> $i repertoires et fichiers ont ete traites" | tee -a Diacs_$now.log
	echo -e "\n`repeat "∋" 33``repeat "∈" 33`\n" | tee -a Diacs_$now.log && exit 0
else
	HELP >&2
	echo -e "Vous devez indiquer un repertoire valide!\n
	Veuillez vous referer a l'aide ci-haut.\n"
	exit 1
fi
exit 0
