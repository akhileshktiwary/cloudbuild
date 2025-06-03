FROM hashicorp/terraform:1.5.6

# Install necessary tools: curl, unzip, bash, python3, pip, gcloud SDK dependencies
RUN apk add --no-cache curl unzip bash python3 py3-pip

# Install terraformer
RUN curl -Lo /tmp/terraformer.zip https://github.com/GoogleCloudPlatform/terraformer/releases/latest/download/terraformer-linux-amd64.zip \
    && unzip /tmp/terraformer.zip -d /usr/local/bin \
    && rm /tmp/terraformer.zip \
    && chmod +x /usr/local/bin/terraformer

# Install gcloud CLI
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-483.0.0-linux-x86_64.tar.gz \
    && tar -xf google-cloud-cli-483.0.0-linux-x86_64.tar.gz \
    && ./google-cloud-sdk/install.sh --quiet \
    && rm google-cloud-cli-483.0.0-linux-x86_64.tar.gz

ENV PATH="/google-cloud-sdk/bin:${PATH}"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
