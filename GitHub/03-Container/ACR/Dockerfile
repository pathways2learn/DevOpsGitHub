FROM ubuntu:18.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
	ca-certificates \
    jq \
    git \
    iputils-ping \
    libcurl4 \
    libicu60 \
    libunwind8 \
    netcat \
    libssl1.0 \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get upgrade

ARG TARGETARCH=amd64
ARG RUNNER_VERSION=2.287.1

WORKDIR /GHRP
RUN \
	GHRP_RUNNERPACKAGE_URL=https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz; \
    curl -LsS "$GHRP_RUNNERPACKAGE_URL" | tar -xz

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]
