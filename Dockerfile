FROM python:3.11 as base

ARG USERNAME=docker
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
USER $USERNAME

# poetry setup
RUN curl -sSL https://install.python-poetry.org | python -
ENV PATH="${PATH}:/home/$USERNAME/.local/bin"

FROM base as dev

WORKDIR /code

CMD [ "/bin/bash" ]
