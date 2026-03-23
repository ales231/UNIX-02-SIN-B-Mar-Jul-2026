gpg --list-secret-keys -keyid-format=long  #para listar las llaves
gpg --armor --export-secret-keys 2BD74A3FCDD98B69 #con nuestra firma ejecutamos este comando y exporta tu llave privada
gpg --list-keys #antes de hacer publica vamos a listar las llaves
gpg --import MICOMPA_llave_publica.asc #con esto exportamos la llave de my friend
gpg --output doc_no_cifrado.txt --encrypt --recipient 573E1A32AF37CBFA47B03919B84A19B106C03AD7 doc_no_cifrado.txt #usamos el hash de la clave publica que importamos de nuestro compañero para cifrar el documento
gpg --decrypt MICOMPA_doc_cifrado.txt #lo traducimos a nuestro idioma el mensaje que nos mando nuesteo companero
gpg --output doc_no_cifrado_firmado.txt --clearsign doc_no_cifrado.txt #Con este comando firmamos en texto limpio nuestro documento