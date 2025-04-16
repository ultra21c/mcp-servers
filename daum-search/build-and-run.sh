#!/bin/bash

# 스크립트를 실행할 때 API 키를 인자로 받습니다
if [ -z "$1" ]; then
  echo "Kakao API 키를 입력해주세요. 예: ./build-and-run.sh YOUR_KAKAO_API_KEY"
  exit 1
fi

KAKAO_API_KEY="$1"

# Docker 이미지 빌드
echo "Docker 이미지를 빌드합니다..."
docker build -t mcp-server-daum-search .

# Docker 컨테이너 실행
echo "Docker 컨테이너를 실행합니다..."
docker run -p 3100:3100 -e KAKAO_API_KEY="$KAKAO_API_KEY" mcp-server-daum-search

echo "MCP 서버가 http://localhost:3100 에서 실행 중입니다." 