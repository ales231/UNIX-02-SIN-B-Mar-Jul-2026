    1  git remote
    2  git fetch upstream
    3  git checkout -b eval_p2_1_v1 upstream/eval_p2_1_v1
    4  git push -u origin eval_p2_1_v1
    5  history
    6  mv registros bitacoras
    7  sudo mv registros bitacoras
    8  cd nebula
    9  ls -la
   10  mkdir bitacoras
   11  mkdir borradores
   12  git add .
   13  ls -la
   14  git commit -m "Fix problema 1: estructura de directorios corregida"
   15  mv cosmos.txt bitacoras/
   16  mv estrella.bak estrella.conf
   17  git add .
   18  git commit -m "Fix problema 2: archivos movidos y renombrados"
   19  chmod 640 bitacoras/cosmos.txt
   20  git add .
   21  git commit -m "Fix problema 3: permisos numericos 640 en cosmos.txt"
   22  chmod u+x galaxia.sh
   23  chmod o-w estrella.conf
   24  git add .
   25  git commit -m "Fix problema 4: permisos simbolicos corregidos"
   26  chmod u+s galaxia.sh
   27  git add .
   28  git commit -m "Fix problema 5: SUID activado en galaxia.sh"
   29  chmod u+s galaxia.sh
   30  sudo chmod +t /tmp/nebula_zone
   31  ls -l galaxia.sh
   32  git commit --allow-empty -m "Fix problema 5: SUID activado en galaxia.sh"
   33  sudo mkdir -p /tmp/nebula_zone
   34  sudo chmod +t /tmp/nebula_zone
   35  ls -ld /temp/nebula_zone
   36  ls -ld /tmp/nebula_zone
   37  sudo chmod o+x /tmp/nebula_zone
   38  ls -ld /tmp/nebula_zone
   39  git commit --allow-empty -m "Fix problema 6: sticky bit en /tmp/nebula_zone"
   40  cat > gpg-batch.txt <<'EOF'
%no-protection
Key-Type: RSA
Key-Length: 3072
Subkey-Type: RSA
Subkey-Length: 3072
Name-Real: aurora
Name-Email: aurora@nebula.lab
Expire-Date: 0
EOF

   41  gpg --batch --generate-key gpg-batch.txt
   42  gpg --yes --output bitacoras/cosmos.txt.gpg --encrypt --recipient aurora@nebula.lab bitacoras/cosmos.txt
   43  git add .
   44  git commit -m "Fix problema 7: llave GPG generada y cosmos.txt cifrado"
   45  gpg --yes --output estrella.conf.asc --clearsign estrella.conf
   46  gpg --verify galaxia.sh.sig galaxia.sh
   47  gpg --yes --output galaxia.sh.sig --detach-sign galaxia.sh
   48  gpg --verify estrella.conf.asc
   49  gpg --verify galaxia.sh.sig galaxia.sh
   50  git add .
   51  git commit -m "Fix problema 8: firmas GPG corregidas y creadas"
   52  history