-- Ensure app_secrets table exists
CREATE TABLE IF NOT EXISTS public.app_secrets (
    key text PRIMARY KEY,
    value text NOT NULL
);
ALTER TABLE public.app_secrets ENABLE ROW LEVEL SECURITY;

-- Allow service_role to read secrets
DROP POLICY IF EXISTS "Allow service_role to read secrets" ON public.app_secrets;
CREATE POLICY "Allow service_role to read secrets" ON public.app_secrets FOR SELECT TO service_role USING (true);

-- Insert the service role key
INSERT INTO public.app_secrets (key, value)
VALUES ('service_role_key', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx5ZXJreWlqcGF2aWx5dWZjcmdiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0ODc1MzQ2NCwiZXhwIjoyMDY0MzI5NDY0fQ.Kll6jTeiqLIGbNGgzQwxVMSpYwKs3LBbAWEbr8x2Y30')
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;
