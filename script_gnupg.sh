gpg --list-secret-keys -keyid-format=long  #para listar las llaves
gpg --armor --export-secret-keys 2BD74A3FCDD98B69 #con nuestra firma ejecutamos este comando y exporta tu llave privada
gpg --list-keys #antes de hacer publica vamos a listar las llaves
gpg --import MICOMPA_llave_publica.asc #con esto exportamos la llave de my friend
gpg --output doc_no_cifrado.txt --encrypt --recipient 573E1A32AF37CBFA47B03919B84A19B106C03AD7 doc_no_cifrado.txt #usamos el hash de la clave publica que importamos de nuestro compañero para cifrar el documento
gpg --decrypt MICOMPA_doc_cifrado.txt #lo traducimos a nuestro idioma el mensaje que nos mando nuestro companero
gpg --output doc_no_cifrado_firmado.txt --clearsign doc_no_cifrado.txt #Con este comando firmamos en texto limpio nuestro documento
cat doc_no_cifrado_firmado.txt #displays the full contents of the file doc_no_cifrado_firmado.txt in the terminal.
gpg --verify MICOMPA_doc_no_cifrado_firmado.txt #checks whether the digital signature of the file MICOMPA_doc_no_cifrado_firmado.txt is valid and whether it was really made with the signer’s key.
gpg --edit-key 573E1A32AF37CBFA47B03919B84A19B106C03AD7 #opens the GPG key management menu for the key with that ID, allowing you to inspect, trust, modify, or manage that key.
gpg --sign-key 573E1A32AF37CBFA47B03919B84A19B106C03AD7 #uses your private key to sign that public key, showing that you trust it and confirm it belongs to that person.
gpg --output doc_no_cifrado_firmado_binario.txt --sign doc_no_cifrado.txt #creates a digitally signed binary version of doc_no_cifrado.txt and saves it as doc_no_cifrado_firmado_binario.txt using your private key.
gpg --output doc_cifrado_y_firmado.txt --encrypt --sign --recipient 573E1A32AF37CBFA47B03919B84A19B106C03AD7 doc_no_cifrado.txt #encrypts and digitally signs doc_no_cifrado.txt, then saves the result as doc_cifrado_y_firmado.txt so that only the specified recipient can decrypt it and also verify that it was signed by you.


