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
  && echo 'eval "$(direnv hook bash)"' >> /home/gitpod/.bashrc

RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && nix-env -iA cachix -f https://cachix.org/api/v1/install \
  && cachix use losercache

# let's cache packages
# RUN mkdir /home/gitpod/nix/
# RUN nix-shell -p curl --command "curl https://raw.githubusercontent.com/agranea/nixos-config/main/shell.nix -o /home/gitpod/shell.nix"
# RUN nix-shell -p curl --command "curl https://raw.githubusercontent.com/agranea/nixos-config/main/nix/pkgs.nix -o /home/gitpod/nix/pkgs.nix"
# RUN nix-shell -p curl --command "curl https://raw.githubusercontent.com/agranea/nixos-config/main/nix/sources.json -o /home/gitpod/nix/sources.json"
# RUN nix-shell -p curl --command "curl https://raw.githubusercontent.com/agranea/nixos-config/main/nix/sources.nix -o /home/gitpod/nix/sources.nix"
# RUN nix-shell --command whoami 

USER root
