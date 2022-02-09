FROM ubuntu:18.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    ca-certificates \
    curl \
    jq \
    git \
    gnupg \
    iputils-ping \
    libcurl4 \
    libicu60 \
    libunwind8 \
    netcat \
    libssl1.0 \
    wget \
    apt-transport-https \
    software-properties-common \
  && rm -rf /var/lib/apt/lists/*

RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb

RUN dpkg -i packages-microsoft-prod.deb

RUN apt-get update

RUN apt-get install -y --no-install-recommends powershell

RUN curl -LsS https://aka.ms/InstallAzureCLIDeb | bash \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install terraform

RUN pwsh -Command "Install-Module -Name 'Az' -Force -Scope 'AllUsers'"
RUN pwsh -Command "Install-Module -Name 'Pester' -Force -Scope 'AllUsers'"
RUN pwsh -Command "Install-Module -Name 'PSScriptAnalyzer' -Force -Scope 'AllUsers'"

RUN apt-get update
RUN apt-get upgrade

ARG TARGETARCH=amd64
ARG AGENT_VERSION=2.195.2

WORKDIR /azp
RUN if [ "$TARGETARCH" = "amd64" ]; then \
      AZP_AGENTPACKAGE_URL=https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz; \
    else \
      AZP_AGENTPACKAGE_URL=https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-${TARGETARCH}-${AGENT_VERSION}.tar.gz; \
    fi; \
    curl -LsS "$AZP_AGENTPACKAGE_URL" | tar -xz

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]
