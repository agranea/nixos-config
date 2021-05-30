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
RUN echo '. /home/gitpod/.nix-profile/etc/profile.d/nix.sh' >> /home/gitpod/.bashrc \
  && nix-env -iA cachix -f https://cachix.org/api/v1/install \
  && cachix use losercache

RUN echo 'eval "$(direnv hook bash)"' >> /home/gitpod/.bashrc

# n. Give back control
USER root
