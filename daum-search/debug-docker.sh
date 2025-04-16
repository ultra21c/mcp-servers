#!/bin/bash

# Docker 이미지 빌드
echo "기존 이미지 제거 중..."
docker rm $(docker ps -a -q -f ancestor=mcp-server-daum-search) 2>/dev/null || true
docker rmi mcp-server-daum-search 2>/dev/null || true

# 임시 Dockerfile 생성
echo "임시 Dockerfile 생성 중..."
cat > Dockerfile.debug << EOF
FROM node:22.12-alpine

# Copy project files
COPY . /app

WORKDIR /app

# 디버깅을 위한 설정
RUN apk add --no-cache bash curl vim

# 의존성 설치 및 빌드
RUN npm install && \\
    mkdir -p dist && \\
    cp index.ts dist/index.js && \\
    echo '// 디버깅용 임시 파일' >> dist/index.js

ENV NODE_ENV=production
ENV KAKAO_API_KEY="bc158ccf0e0c934d9245e303737931da"

# 셸 유지
CMD ["tail", "-f", "/dev/null"]
EOF

# 디버깅용 이미지 빌드
echo "디버깅용 이미지 빌드 중..."
docker build -t mcp-server-daum-search:debug -f Dockerfile.debug .

# 컨테이너 실행
echo "디버깅용 컨테이너 실행 중..."
docker run -d -p 3100:3100 --name mcp-debug mcp-server-daum-search:debug

echo "컨테이너에 접속하기:"
echo "docker exec -it mcp-debug bash"
echo ""
echo "노드 서버 수동 실행하기:"
echo "docker exec -it mcp-debug node dist/index.js" 