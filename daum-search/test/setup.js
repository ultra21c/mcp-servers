// Jest setup file
// This file runs before each test

// Set longer timeout for integration tests
jest.setTimeout(30000);

// Mock console.error for cleaner test output
const originalConsoleError = console.error;
beforeEach(() => {
  console.error = jest.fn();
});

afterEach(() => {
  console.error = originalConsoleError;
});

// Ensure required environment variables are set
beforeAll(() => {
  if (!process.env.KAKAO_API_KEY) {
    throw new Error('KAKAO_API_KEY environment variable is required for testing');
  }
});
