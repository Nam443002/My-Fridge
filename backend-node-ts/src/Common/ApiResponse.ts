// Standard API response envelope — { success, data, error, traceId, timestamp }
export interface ApiResponse<T> {
  success: boolean;
  data: T | null;
  error: ApiError | null;
  traceId: string;
  timestamp: string;
}
export interface ApiError { code: string; message: string }
