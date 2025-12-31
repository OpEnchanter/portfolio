# syntax=docker/dockerfile:1

# Stage 1: Base image
FROM oven/bun:1 AS base
WORKDIR /usr/src/app

# Stage 2: Install dependencies (dev)
FROM base AS install
RUN mkdir -p /temp/dev
COPY package.json bun.lock /temp/dev/
RUN cd /temp/dev && bun install --frozen-lockfile

# Stage 3: Install dependencies (production)
FROM base AS prod_deps
RUN mkdir -p /temp/prod
COPY package.json bun.lock /temp/prod/
RUN cd /temp/prod && bun install --frozen-lockfile --production

# Stage 4: Prerelease - Copy everything and install dev dependencies
FROM base AS prerelease
COPY --from=install /temp/dev/node_modules ./node_modules
COPY . .

# Stage 5: Release - Only copy production deps and app code
FROM base AS release
WORKDIR /usr/src/app
COPY --from=prod_deps /temp/prod/node_modules ./node_modules
COPY --from=prerelease /usr/src/app/. .

USER bun
EXPOSE 3000
ENTRYPOINT [ "bun", "index.ts" ]