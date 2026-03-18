FROM ghcr.io/gitroomhq/postiz-app:v2.20.2

USER root

RUN sed -i 's|: await this.storage.uploadSimple(picture)|: await this.storage.uploadSimple(picture).catch((err) => { console.error("Uploading the integrations image failed."); console.error(err); return undefined; })|g' \
    /app/apps/backend/dist/libraries/nestjs-libraries/src/database/prisma/integrations/integration.service.js

RUN sed -i 's|throw new BadRequestException()|console.error("Integration provider flow failed", e); throw new BadRequestException()|g' \
    /app/apps/backend/dist/apps/backend/src/api/routes/integrations.controller.js || true
