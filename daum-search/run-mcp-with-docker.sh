#!/bin/bash

echo "MCP 서버를 Docker에서 실행합니다"
echo "주의: 이 모드는 디버깅 목적으로만 사용하세요. 실제 사용은 설치 후 Claude Desktop과 통합하는 것이 좋습니다."
echo ""

# API 키 확인
if [ -z "$1" ]; then
  echo "Kakao API 키를 입력해주세요. 예: ./run-mcp-with-docker.sh YOUR_KAKAO_API_KEY"
  exit 1
fi

KAKAO_API_KEY="$1"

# Docker 이미지 실행 (stdin 유지)
docker run -i --rm -e KAKAO_API_KEY="$KAKAO_API_KEY" mcp-server-daum-search

echo "서버가 종료되었습니다." 