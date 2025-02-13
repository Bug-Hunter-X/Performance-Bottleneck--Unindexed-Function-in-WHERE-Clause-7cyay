To resolve this, we need to either (1) create a new indexed column (if possible) that holds the result of the function, or (2) restructure the query to avoid the function within the comparison if possible.

**Option 1 (Adding an indexed column):**  This involves adding a new column (e.g., `email_prefix`) to the `users` table and indexing it.  The `email_prefix` would contain the first 5 characters of the `email` address.

```sql
ALTER TABLE users ADD COLUMN email_prefix VARCHAR(5);
UPDATE users SET email_prefix = SUBSTR(email, 1, 5);
CREATE INDEX idx_email_prefix ON users (email_prefix);
```

The query can then be rewritten using this new column:

```sql
SELECT * FROM users WHERE email_prefix = 'test@';
```

**Option 2 (Restructuring the Query):**  If adding a new column isn't feasible, try restructuring your query to avoid using the function in the comparison. This might not always be possible, and the alternative may not be as efficient.  This often requires a deeper understanding of your specific data and query requirements.  For example, full text search might be a better approach if you are searching within the string for a particular word or phrase.