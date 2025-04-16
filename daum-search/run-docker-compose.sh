#!/bin/bash

# 스크립트를 실행할 때 API 키를 인자로 받습니다
if [ -z "$1" ]; then
  echo "Kakao API 키를 입력해주세요. 예: ./run-docker-compose.sh YOUR_KAKAO_API_KEY"
  exit 1
fi

KAKAO_API_KEY="$1"

# .env 파일 생성 (API 키 설정)
echo "# Kakao API 키를 설정합니다" > .env
echo "KAKAO_API_KEY=$KAKAO_API_KEY" >> .env

# Docker Compose로 실행
echo "Docker Compose로 MCP 서버를 실행합니다..."
docker-compose up -d

echo "MCP 서버가 http://localhost:3100 에서 백그라운드로 실행 중입니다."
echo "로그를 확인하려면: docker-compose logs -f"
echo "서버를 중지하려면: docker-compose down" 