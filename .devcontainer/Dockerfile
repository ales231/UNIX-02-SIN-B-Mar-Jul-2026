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