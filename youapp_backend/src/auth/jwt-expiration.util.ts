import type { StringValue } from 'ms';

// Helper to convert JWT_EXPIRATION to a valid type for expiresIn
export function getJwtExpiresIn(): number | StringValue | undefined {
  const exp = process.env.JWT_EXPIRATION;
  if (!exp) return undefined;
  const num = Number(exp);
  if (!isNaN(num)) return num;
  // Jika bukan angka, kembalikan string (misal '1h', '7d', dsb)
  return exp as StringValue;
}
