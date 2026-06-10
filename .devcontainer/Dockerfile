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
# ----------------------------------------------------------------------------
# (e) RUN — install every course package in ONE layer
# ----------------------------------------------------------------------------
#   apt-get update   -> refresh the local index of available packages
#   apt-get install  -> download and install the listed packages
#     -y                       -> auto-answer "yes" to confirmations
#     --no-install-recommends  -> install only hard dependencies, skipping
#                                 "recommended" extras; saves hundreds of MB
#
# Why one giant RUN instead of many small ones? Each RUN is a separate
# layer. Fewer layers means a smaller, faster image — and update+install
# share one layer so we never cache a stale package index against a fresh
# install (Docker image hygiene — BHB Ch.3).
#
# "&&" chains commands so the next runs ONLY if the previous succeeded
# (logical AND / exit-status control flow — BHB Ch.1/Ch.2). The trailing
# "\" continues the same shell command onto the next line. If any step
# fails the whole RUN aborts, which is what we want: a clear error beats a
# half-built image.
RUN apt-get update && apt-get install -y --no-install-recommends \
    \
    # === Editors and shells (command interpreters) ===
    neovim \
    vim \
    bash \
    bash-completion \
    \
    # === Text-processing power tools ===
    # The workhorses of shell scripting: gawk/sed/grep filter and transform
    # text streams; perl/make round out the toolkit (grep/sed/awk for
    # pattern matching and stream editing — BHB Ch.2).
    perl \
    make \
    gawk \
    sed \
    grep \
    \
    # === Core UNIX utilities ===
    # coreutils -> cat, ls, head, tail, sort, cut, tr, etc.
    # findutils -> find and xargs.
    # procps    -> ps, top, kill (process management).
    # less = pager for long output; tree = directory tree view;
    # jq = command-line JSON processor (handy for parsing tool output).
    coreutils \
    findutils \
    procps \
    less \
    tree \
    jq \
    \
    # === Manual pages (the `man` command) ===
    # Kali's base image strips docs to save space; we reinstall them because
    # "man bash" / "man grep" are constant references in the course.
    man-db \
    manpages \
    manpages-posix \
    \
    # === Basic networking and downloaders ===
    curl \
    wget \
    git \
    git-lfs \
    ca-certificates \
    locales \
    \
    # === Linter (static analysis) for Bash scripts ===
    # shellcheck flags bugs and bad patterns before you ever run a script.
    shellcheck \
    \
    # === Recon and network scanning ===
    # nmap = the standard port/service scanner.
    # masscan = mass scanning across large IP ranges.
    nmap \
    masscan \
    \
    # === Packet capture and analysis ===
    # tcpdump = classic terminal capture; tshark = Wireshark's CLI engine.
    tcpdump \
    tshark \
    \
    # === Assorted network utilities ===
    netcat-traditional \
    socat \
    dnsutils \
    whois \
    traceroute \
    mtr-tiny \
    iproute2 \
    net-tools \
    iputils-ping \
    \
    # === Anonymity: Tor and friends ===
    # tor = Tor client; torsocks = wrapper that pushes any command through
    # Tor; proxychains4 = chains multiple proxies; obfs4proxy = obfuscates
    # Tor traffic to evade blocking.
    tor \
    torsocks \
    proxychains4 \
    obfs4proxy \
    \
    # === Friendlier HTTP client for learning ===
    httpie \
    \
# (f) --- Enable the Spanish locale ---
 # sed edits /etc/locale.gen in place (-i) and uncomments the es_ES.UTF-8
 # line by substituting "# es_ES.UTF-8" with "es_ES.UTF-8" (sed
 # substitution / in-place stream editing — BHB Ch.2). locale-gen then
 # compiles the locale data so LANG/LC_ALL set above actually resolve.
 && sed -i 's/# es_ES.UTF-8/es_ES.UTF-8/' /etc/locale.gen \
 && locale-gen \
 \
 # (g) --- Final cleanup: shrink the image ---
 # apt leaves cache files and package lists behind after installing. We
 # delete them in the SAME RUN so they never get committed into this layer.
 # Cleaning in a later RUN would not help: the bytes would already be frozen
 # in the earlier layer and still count toward image size.
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
# ----------------------------------------------------------------------------
# (h) SHELL — which interpreter later RUN steps use
# ----------------------------------------------------------------------------
# By default Docker runs RUN commands through /bin/sh, a minimal POSIX
# shell. We switch to bash so any later steps can use bash-only syntax
# (arrays, [[ ]], etc.). This is the same sh-vs-bash distinction covered in
# the shell basics (the shell as command interpreter — BHB Ch.1).
SHELL ["/bin/bash", "-c"]


# ----------------------------------------------------------------------------
# (i) WORKDIR — default working directory inside the container
# ----------------------------------------------------------------------------
# Codespaces mounts the repo at /workspaces/<repo-name>. Setting WORKDIR to
# /workspaces means new shells open next to the course files instead of /,
# so relative paths in scripts behave as expected.
WORKDIR /workspaces
# ----------------------------------------------------------------------------
# (j) Git configuration baked into the image
# ----------------------------------------------------------------------------
# --system writes to the machine-wide gitconfig so every shell inherits it.
# - safe.directory '*' : trust any mounted repo. Needed because the mounted
#   /workspaces/... files have a different UID than root inside the
#   container, which otherwise triggers Git's "dubious ownership" block.
# - init.defaultBranch main : new repos start on "main", silencing the
#   master-vs-main warning.
# - pull.rebase false : pull defaults to merge (simpler mental model).
# - git lfs install --system : registers Git LFS hooks globally so repos
#   using large-file storage work without per-repo setup.
RUN git config --system --add safe.directory '*' \
 && git config --system init.defaultBranch main \
 && git config --system pull.rebase false \
 && git lfs install --system
 # ----------------------------------------------------------------------------
# (k/l) Default shell prompt — written via a here-document
# ----------------------------------------------------------------------------
# This image keeps bash as the login shell rather than switching to zsh, so
# instead of editing /root/.zshrc we write /root/.bashrc. (If we wanted zsh
# as the default we would run `chsh -s /usr/bin/zsh root` to change root's
# login shell and configure .zshrc instead — same idea, different shell.)
#
# A here-document feeds a literal block of text to a command as its stdin.
# `cat > file <<'EOF' ... EOF` means: send every line up to EOF into cat,
# which writes it to the file. Quoting the delimiter as 'EOF' disables
# variable/backtick expansion, so the prompt escape codes are stored
# verbatim instead of being evaluated now (here-documents and redirection —
# BHB Ch.1).
#
# The __set_prompt function rebuilds PS1 (bash's primary prompt string)
# before each prompt. It captures the previous command's exit status ($?)
# first, then shows a green ✓ on success or a red ✗ with the code on failure
# (exit status / $? — BHB Ch.1). PROMPT_COMMAND tells bash to run that
# function before drawing every prompt. PS1 itself prints the course tag,
# the current directory (\W), the status mark, and the trailing $.
RUN cat > /root/.bashrc <<'EOF'



__set_prompt() {
    local ec=$?
    local mark
    if [ $ec -eq 0 ]; then
        mark='\[\e[32m\]✓\[\e[0m\]'
    else
        mark="\[\e[31m\]✗ $ec\[\e[0m\]"
    fi
    PS1="\[\e[36m\][Alex Alban]\[\e[0m\] \[\e[33m\]\W\[\e[0m\] $mark \$ "
}
PROMPT_COMMAND=__set_prompt
EOF


# ----------------------------------------------------------------------------
# (m) CMD — the default process when the container starts
# ----------------------------------------------------------------------------
# CMD differs from RUN: RUN executes at BUILD time and bakes results into
# the image, while CMD only defines what runs at START time when a container
# launches. Here it starts an interactive bash shell. Codespaces overrides
# this with its own VS Code terminal, but defining it keeps the image usable
# under plain `docker run` too.
CMD ["/bin/bash"]