# ============================================================================
#  Dockerfile — build recipe for the course image
# ============================================================================
#  A Dockerfile is a plain-text script of instructions that Docker reads
#  top to bottom to assemble an "image": a frozen, ready-to-run snapshot of
#  a Linux system. Each time the Codespace opens, Docker spins up a
#  "container" — a live, writable instance — from that read-only image.
#  (Containers and the lab setup — BHB Ch.3.)
#
#  Mental model: the image is the blueprint, the container is the house.
#
#  Layer/cache idea: every instruction (FROM, ENV, RUN...) produces one
#  cached layer. If the lines above a change are untouched, Docker reuses
#  their cached layers and rebuilds only from the changed line down. That
#  is why instruction ORDER matters: put rarely-changing, expensive steps
#  (base image, package installs) near the top so edits to later steps
#  don't force a full reinstall.
# ============================================================================


# ----------------------------------------------------------------------------
# (a) FROM — the base image we build on top of
# ----------------------------------------------------------------------------
# Instead of starting from an empty filesystem, we inherit a complete OS.
# A base image is a pre-built starting point; everything below stacks on
# top of it as new layers. We pick Kali Linux because it ships with the
# offensive-security tooling the course targets, so we add fewer packages
# ourselves (Kali as the lab distro — BHB Ch.3). The "rolling" tag means
# continuous updates, so the base stays current.
FROM kalilinux/kali-rolling:latest
# ----------------------------------------------------------------------------
# (c) ENV — persistent environment variables inside the container
# ----------------------------------------------------------------------------
# Environment variables are global key/value settings any process can read
# from its environment; by convention they are UPPERCASE (environment
# variables — BHB Ch.1).
#
#   DEBIAN_FRONTEND=noninteractive
#     Tells apt not to open interactive dialogs and to take defaults. A
#     build has no human at the keyboard, so a prompt would hang forever.
#
#   LANG / LC_ALL=es_ES.UTF-8
#     Set the system language and, crucially, the UTF-8 character encoding
#     so accents, ñ, €, etc. render correctly. LC_ALL overrides every other
#     locale category at once.
#
#   TERM=xterm-256color
#     Advertises a 256-color terminal so tools like vim/htop use full color.
#
# The trailing "\" continues one logical instruction across several lines;
# it is purely for readability and groups these into a single ENV layer.
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=es_ES.UTF-8 \
    LC_ALL=es_ES.UTF-8 \
    TERM=xterm-256color
# ----------------------------------------------------------------------------
# (d) Pre-seed Wireshark's interactive install prompt
# ----------------------------------------------------------------------------
# Installing wireshark/tshark normally pops a question: should non-root
# users be allowed to capture packets? We answer it in advance so the build
# never stops for input. The "echo ... | debconf-set-selections" pattern
# feeds the canned answer "false" — we run as root in the container, so
# unprivileged capture is unneeded. Note the pipe "|": echo's stdout becomes
# debconf's stdin (pipes and stdin/stdout — BHB Ch.1).
RUN echo "wireshark-common wireshark-common/install-setuid boolean false" \
    | debconf-set-selections