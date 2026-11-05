// Core API client: Axios instance with JWT interceptor and TraceId header injection.
export interface ApiClientConfig { baseUrl: string }
export interface ApiResponse<T> {
  success: boolean; data: T | null;
  error: { code: string; message: string } | null;
  traceId: string; timestamp: string;
}
