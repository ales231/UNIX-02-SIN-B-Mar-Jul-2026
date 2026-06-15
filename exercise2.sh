#!/usr/bin/env bash
#
# exercise2.sh - Califica del 1 al 100 una rama de Git segun el comportamiento
#                de los commits y la calidad de la documentacion.
#
# Criterios y peso sobre 100 puntos:
#   - 40 pts -> commits hechos en HORA DE CLASE (07:00 a 09:00, hora local de clase)
#   - 20 pts -> VARIEDAD de commits (cantidad razonable + mensajes no repetidos)
#   - 20 pts -> HORARIO / regularidad (cuantos dias distintos se trabajo)
#   - 20 pts -> CALIDAD DE COMENTARIOS (mensajes de commit + comentarios "#" en .sh)
#
# Uso:
#   ./exercise2.sh [rama]
#   ./exercise2.sh blackhatbash
#
# Variables de entorno opcionales:
#   CLASS_TZ     Zona horaria de la clase (default: America/Guayaquil = UTC-5)
#   CLASS_START  Hora de inicio de clase  (default: 7)
#   CLASS_END    Hora de fin de clase     (default: 9)  -> intervalo [START, END)
#
set -euo pipefail

# --------------------------------------------------------------------------- #
# Configuracion
# --------------------------------------------------------------------------- #
RAMA="${1:-blackhatbash}"            # rama a evaluar (por defecto blackhatbash)
CLASS_TZ="${CLASS_TZ:-America/Guayaquil}"   # zona horaria de la clase
CLASS_START="${CLASS_START:-7}"      # la clase empieza 07:00
CLASS_END="${CLASS_END:-9}"          # la clase termina 09:00

# Metas usadas para normalizar los puntajes
META_COMMITS=15                      # cantidad de commits que vale el 100% de "cantidad"
META_DIAS=5                          # dias distintos que valen el 100% de "regularidad"
DENSIDAD_OBJETIVO=15                 # % de lineas de comentario que valen el 100%

# --------------------------------------------------------------------------- #
# Validaciones previas
# --------------------------------------------------------------------------- #
if ! command -v git >/dev/null 2>&1; then
    echo "ERROR: git no esta instalado." >&2
    exit 1
fi
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "ERROR: este script debe ejecutarse dentro de un repositorio git." >&2
    exit 1
fi
if ! git rev-parse --verify "$RAMA" >/dev/null 2>&1; then
    # Si no existe localmente, intenta usar la rama remota origin/<rama>
    if git rev-parse --verify "origin/$RAMA" >/dev/null 2>&1; then
        RAMA="origin/$RAMA"
    else
        echo "ERROR: la rama '$RAMA' no existe en este repositorio." >&2
        echo "Ramas disponibles:" >&2
        git branch -a >&2
        exit 1
    fi
fi

# --------------------------------------------------------------------------- #
# Funcion auxiliar: evalua una expresion aritmetica con decimales usando awk
# (awk viene en todo sistema Unix, asi no dependemos de 'bc').
# Para condiciones usa el operador ternario de awk:  (cond ? valor1 : valor2)
# --------------------------------------------------------------------------- #
calc() { awk "BEGIN{printf \"%.4f\", ($1)}"; }
round2() { printf "%.2f" "$1"; }

TOTAL=$(git rev-list --count "$RAMA")
if [ "$TOTAL" -eq 0 ]; then
    echo "ERROR: la rama '$RAMA' no tiene commits." >&2
    exit 1
fi

# =========================================================================== #
# 1) COMMITS EN HORA DE CLASE  (40 pts)
#    Se convierte el INSTANTE absoluto de cada commit a la zona horaria de la
#    clase y se cuenta cuantos caen en el intervalo [CLASS_START, CLASS_END).
# =========================================================================== #
EN_CLASE=0
while read -r epoch; do
    [ -z "$epoch" ] && continue
    hora=$(TZ="$CLASS_TZ" date -d "@$epoch" +%H)
    hora=$((10#$hora))                       # fuerza base 10 (evita "08" octal)
    if [ "$hora" -ge "$CLASS_START" ] && [ "$hora" -lt "$CLASS_END" ]; then
        EN_CLASE=$((EN_CLASE + 1))
    fi
done < <(git log --pretty='%at' "$RAMA")

PTS_CLASE=$(calc "40 * $EN_CLASE / $TOTAL")

# =========================================================================== #
# 2) VARIEDAD DE COMMITS  (20 pts)
#    a) cantidad de commits (10 pts, tope en META_COMMITS)
#    b) proporcion de mensajes UNICOS vs repetidos (10 pts)
# =========================================================================== #
MSGS_UNICOS=$(git log --pretty='%s' "$RAMA" | sort | uniq | wc -l)

FACTOR_CANT=$(calc "($TOTAL/$META_COMMITS > 1 ? 1 : $TOTAL/$META_COMMITS)")
FACTOR_UNIC=$(calc "$MSGS_UNICOS / $TOTAL")
PTS_VARIEDAD=$(calc "10 * $FACTOR_CANT + 10 * $FACTOR_UNIC")

# =========================================================================== #
# 3) HORARIO / REGULARIDAD  (20 pts)
#    Mide en cuantos DIAS distintos (hora local de clase) hubo actividad.
# =========================================================================== #
DIAS_DISTINTOS=$(git log --pretty='%at' "$RAMA" \
    | while read -r e; do TZ="$CLASS_TZ" date -d "@$e" +%Y-%m-%d; done \
    | sort -u | wc -l)

FACTOR_DIAS=$(calc "($DIAS_DISTINTOS/$META_DIAS > 1 ? 1 : $DIAS_DISTINTOS/$META_DIAS)")
PTS_HORARIO=$(calc "20 * $FACTOR_DIAS")

# =========================================================================== #
# 4) CALIDAD DE COMENTARIOS  (20 pts)
#    a) Calidad de los MENSAJES de commit (10 pts)
#    b) Densidad de comentarios "#" en los archivos .sh de la rama (10 pts)
# =========================================================================== #

# --- 4a) mensajes de commit ---
# Cada mensaje suma: 1.0 si es descriptivo (>=15 chars y >=2 palabras),
#                    0.5 si es corto pero valido,
#                    0.0 si es generico/vacio.
SUMA_MSG=0
GENERICOS="update test fix wip commit changes change . .. asdf cambios prueba"
while IFS= read -r msg; do
    largo=${#msg}
    palabras=$(echo "$msg" | wc -w)
    minus=$(echo "$msg" | tr '[:upper:]' '[:lower:]' | xargs 2>/dev/null || echo "$msg")
    es_generico=0
    for g in $GENERICOS; do
        [ "$minus" = "$g" ] && es_generico=1 && break
    done
    if [ "$es_generico" -eq 1 ] || [ "$largo" -lt 5 ]; then
        nota="0"
    elif [ "$largo" -ge 15 ] && [ "$palabras" -ge 2 ]; then
        nota="1"
    else
        nota="0.5"
    fi
    SUMA_MSG=$(calc "$SUMA_MSG + $nota")
done < <(git log --pretty='%s' "$RAMA")

PTS_MSG=$(calc "10 * $SUMA_MSG / $TOTAL")

# --- 4b) comentarios dentro de los .sh ---
LINEAS_COMENTARIO=0
LINEAS_CODIGO=0
ARCHIVOS_SH=$(git ls-tree -r --name-only "$RAMA" | grep -E '\.sh$' || true)

if [ -n "$ARCHIVOS_SH" ]; then
    while IFS= read -r archivo; do
        [ -z "$archivo" ] && continue
        # Lee el archivo TAL CUAL esta en la rama (sin depender del working tree)
        contenido=$(git show "$RAMA:$archivo" 2>/dev/null || true)
        c=$(echo "$contenido" | awk '
            { sub(/^[ \t]+/, "") }                 # quita espacios al inicio
            /^#!/   { next }                        # ignora el shebang
            /^#/    { com++; next }                 # linea de comentario
            /^$/    { next }                        # linea vacia
            { cod++ }                               # cualquier otra es codigo
            END { print com+0, cod+0 }')
        LINEAS_COMENTARIO=$((LINEAS_COMENTARIO + $(echo "$c" | awk '{print $1}')))
        LINEAS_CODIGO=$((LINEAS_CODIGO + $(echo "$c" | awk '{print $2}')))
    done <<< "$ARCHIVOS_SH"
fi

TOTAL_LINEAS=$((LINEAS_COMENTARIO + LINEAS_CODIGO))
if [ "$TOTAL_LINEAS" -gt 0 ]; then
    DENSIDAD=$(calc "100 * $LINEAS_COMENTARIO / $TOTAL_LINEAS")
    FACTOR_DENS=$(calc "($DENSIDAD/$DENSIDAD_OBJETIVO > 1 ? 1 : $DENSIDAD/$DENSIDAD_OBJETIVO)")
else
    DENSIDAD=0
    FACTOR_DENS=0
fi
PTS_DENSIDAD=$(calc "10 * $FACTOR_DENS")

PTS_COMENTARIOS=$(calc "$PTS_MSG + $PTS_DENSIDAD")

# =========================================================================== #
# RESULTADO FINAL
# =========================================================================== #
TOTAL_PTS=$(calc "$PTS_CLASE + $PTS_VARIEDAD + $PTS_HORARIO + $PTS_COMENTARIOS")
# El puntaje minimo es 1 (la consigna pide calificar del 1 al 100)
NOTA_FINAL=$(calc "($TOTAL_PTS < 1 ? 1 : $TOTAL_PTS)")
# La consigna pide calificar SOBRE 100 -> se entrega como numero entero
NOTA_ENTERA=$(awk "BEGIN{printf \"%.0f\", $NOTA_FINAL}")

echo "============================================================"
echo "  CALIFICACION DE LA RAMA: $RAMA"
echo "  Repositorio: $(basename "$(git rev-parse --show-toplevel)")"
echo "  Zona horaria de clase: $CLASS_TZ  (${CLASS_START}:00 - ${CLASS_END}:00)"
echo "============================================================"
printf "  Total de commits evaluados : %d\n" "$TOTAL"
echo "------------------------------------------------------------"
printf "  1) Hora de clase   (40) : %6s  -> %d/%d commits en clase\n" "$(round2 "$PTS_CLASE")" "$EN_CLASE" "$TOTAL"
printf "  2) Variedad        (20) : %6s  -> %d msgs unicos / %d\n"    "$(round2 "$PTS_VARIEDAD")" "$MSGS_UNICOS" "$TOTAL"
printf "  3) Horario/regular (20) : %6s  -> %d dias trabajados\n"     "$(round2 "$PTS_HORARIO")" "$DIAS_DISTINTOS"
printf "  4) Comentarios     (20) : %6s  -> msgs %s/10 | codigo %s/10 (%.1f%% densidad)\n" \
        "$(round2 "$PTS_COMENTARIOS")" "$(round2 "$PTS_MSG")" "$(round2 "$PTS_DENSIDAD")" "$DENSIDAD"
echo "------------------------------------------------------------"
printf "  NOTA FINAL : %d / 100\n" "$NOTA_ENTERA"
echo "============================================================"
