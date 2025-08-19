FROM mcr.microsoft.com/playwright:v1.54.2-noble

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-venv python3-dev build-essential git \
 && rm -rf /var/lib/apt/lists/* \
 && ln -sf /usr/bin/python3 /usr/bin/python \
 && ln -sf /usr/bin/pip3 /usr/bin/pip   

ARG PORT=8051

WORKDIR /app

# Install uv
RUN pip install --break-system-packages uv

# Copy the MCP server files
COPY . .

# Create a virtual environment and add it to the PATH
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install packages into the virtual environment
RUN uv pip install -e . && \
    crawl4ai-setup && \
    playwright install-deps && \
    playwright install

EXPOSE ${PORT}

# Command to run the MCP server
CMD ["python", "src/crawl4ai_mcp.py"]
