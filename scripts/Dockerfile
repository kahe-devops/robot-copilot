# syntax=docker/dockerfile:1.2

# M$ devcontainer needed for python debugging support
FROM mcr.microsoft.com/vscode/devcontainers/python:3.9-bullseye

LABEL Robot in Docker

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash

# Define the default user who'll run the tests
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Setup the timezone to use, defaults to UTC
ENV TZ=Europe/Helsinki

# Set the reports directory environment variable
ENV ROBOT_REPORTS_DIR /opt/robotframework/reports

# Set the tests directory environment variable
ENV ROBOT_TESTS_DIR /opt/robotframework/tests

# Set the working directory environment variable
ENV ROBOT_WORK_DIR /opt/robotframework

# Set number of threads for parallel execution
# By default, no parallelisation
ENV ROBOT_THREADS 1
ENV NODE_MAJOR 20

# Install updates
RUN apt-get update \
    && apt-get install -y wget ca-certificates curl gcc g++ gnupg make ntpdate openssl openssh-client \
    ## To install the Yarn package manager, run:
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install yarn \
# Install Node.js and npm
# Clean old nodejs first
    && apt remove nodejs libnode72 \
    && rm -rf /usr/local/bin/node* \
    && rm -rf /usr/local/bin/npm* \
    && rm -rf /etc/apt/sources.list.d/nodesource.list \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y nodejs \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install Robot Framework and Browser library
RUN pip3 install \
        --upgrade pip \
        --no-cache-dir \
        -r scripts/requirements.txt

# Install Browser library dependencies
RUN python3 -m Browser.entry init
RUN npx playwright install-deps

# Create the default report and work folders with the default user to avoid runtime issues
# These folders are writeable by anyone, to ensure the user can be changed on the command line.
RUN mkdir -p ${ROBOT_REPORTS_DIR} \
    && mkdir -p ${ROBOT_WORK_DIR} \
    && chmod ugo+w ${ROBOT_REPORTS_DIR} ${ROBOT_WORK_DIR}

# Update system path
ENV PATH=/opt/robotframework/bin:/opt/robotframework/drivers:$PATH

# Set up a volume for the generated reports
VOLUME ${ROBOT_REPORTS_DIR}

# A dedicated work folder for the test execution
WORKDIR ${ROBOT_WORK_DIR}

# /bin/bash
CMD ["/bin/bash"]