# Showcase

Material from this project that is meant to be public: case studies, curated decisions and
extracted code, usually on their way to `felpsxp-architecture`. Everything here is reviewed against
the checklist below before it leaves a private repository.

## The golden rule

Document the capability, never the map.

## Before publishing

Nothing in the material may contain:

- [ ] credentials, tokens, keys or the values of environment variables;
- [ ] private addresses, MAC addresses, hostnames or network ranges;
- [ ] device names or anything that describes the real topology of a network;
- [ ] names of people or other personal data (LGPD);
- [ ] internal file paths, internal URLs or provider project references;
- [ ] business rules that are the product's competitive advantage.

Then confirm:

- [ ] `gitleaks` is clean on the material, before the first push;
- [ ] a search for private address ranges and MAC patterns finds only deliberate examples;
- [ ] every status line says what exists today, and a decision not yet built says so;
- [ ] a person read each file. A runbook, test or archived document is never copied verbatim.

Pushing a branch to a public repository already publishes it, so this review comes before the
push, not before the merge.
