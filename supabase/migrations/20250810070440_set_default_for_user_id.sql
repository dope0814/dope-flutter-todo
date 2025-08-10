ALTER TABLE public.todos
ALTER COLUMN user_id SET DEFAULT auth.uid();
