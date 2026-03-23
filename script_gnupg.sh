gpg --list-secret-keys -keyid-format=long  #para listar las llaves
gpg --armor --export-secret-keys 2BD74A3FCDD98B69 #con nuestra firma ejecutamos este comando y exporta tu llave privada
gpg --list-keys #antes de hacer publica vamos a listar las llaves
gpg --import MICOMPA_llave_publica.asc #con esto exportamos la llave de my friend