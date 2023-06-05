FROM squidfunk/mkdocs-material:9.0.9

ENV MKDOCS_MONOREPO_REPO=https://github.com/PauloASilva/mkdocs-monorepo-plugin
ENV MKDOCS_MONOREPO_BRANCH="feat/i18n"

RUN python -m pip install git+$MKDOCS_MONOREPO_REPO@$MKDOCS_MONOREPO_BRANCH
RUN python -m pip install pymdown-extensions
