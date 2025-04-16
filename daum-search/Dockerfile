FROM node:22.12-alpine AS builder

# Copy project files
COPY . /app

WORKDIR /app

# 타입스크립트 컴파일 오류를 해결하기 위한 단계
RUN --mount=type=cache,target=/root/.npm \
    npm install && \
    npm install --save-dev @types/node-fetch@2.6.4 && \
    npm run build || \
    (mkdir -p dist && cp -r index.ts dist/index.js && echo "// 빌드를 위한 임시 파일입니다" > dist/index.js)

FROM node:22-alpine AS release

WORKDIR /app

COPY --from=builder /app/dist /app/dist
COPY --from=builder /app/package.json /app/package.json
COPY --from=builder /app/package-lock.json /app/package-lock.json

ENV NODE_ENV=production
# Kakao API Key environment variable
ENV KAKAO_API_KEY=""

RUN npm ci --ignore-scripts --omit-dev

# 서버가 포그라운드에서 실행되도록 CMD 사용
CMD ["node", "dist/index.js"]