# Runbooks

Step-by-step procedures for operating this project: local setup, restoring a backup, rotating a
secret, recovering from a known failure. A runbook is written for someone tired, at a bad moment,
who has never done this before.

Each runbook states when to use it, what it needs, the exact commands in order, and how to confirm
it worked. Name files in kebab-case (`restore-from-backup.md`).

Keep real hostnames, addresses and credentials out of this folder. Reference them by the name of
the environment variable or secret that holds them.
