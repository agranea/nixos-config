FROM gitpod/workspace-full:latest

# 0. Switch to root
USER root

# 1. Install direnv & git-lfs
RUN apt-get install direnv \
                    git-lfs

# 2. Install Nix
RUN addgroup --system nixbld \
  && usermod -a -G nixbld gitpod \
  && mkdir -m 0755 /nix && chown gitpod /nix \
  && mkdir -p /etc/nix && echo 'sandbox = false' > /etc/nix/nix.conf

CMD /bin/bash -l
USER gitpod
ENV USER gitpod
WORKDIR /home/gitpod

RUN touch .bash_profile && \
  curl -L https://nixos.org/nix/install | sh

RUN mkdir -p /home/gitpod/.config/nixpkgs && echo '{ allowUnfree = true; }' >> /home/gitpod/.config/nixpkgs/config.nix

# Set cache on container level
RUN mkdir -p /home/gitpod/.config/nix
RUN echo 'substituters = https://cache.nixos.org https://losercache.cachix.org' >> /home/gitpod/.config/nix/nix.conf
RUN echo 'trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= losercache.cachix.org-1:BSADU4/PYhX46Uk3e6SyE7T9u1N4S2H5znLtbt6R6NQ='

RUN echo '. /home/gitpod/.nix-profile/etc/profile.d/nix.sh' >> /home/gitpod/.bashrc
RUN echo 'eval "$(direnv hook bash)"' >> /home/gitpod/.bashrc

# n. Give back control
USER root
