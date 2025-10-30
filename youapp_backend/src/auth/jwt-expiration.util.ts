// Helper to convert JWT_EXPIRATION to a valid type for expiresIn
export function getJwtExpiresIn(): number | undefined {
  const exp = process.env.JWT_EXPIRATION;
  if (!exp) return undefined;
  const num = Number(exp);
  if (!isNaN(num)) return num;
  // Accepts string like '1d', '2h', etc. for StringValue
  return undefined;
}
