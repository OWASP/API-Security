FROM squidfunk/mkdocs-material:9.0.9

COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --no-cache-dir -r /tmp/requirements.txt