# Category: Cross-Layer / Integration (DRAFT)

**Scope:** Contracts and interfaces between Termux host (Bionic, `aarch64-linux-android`) and Ubuntu guest (glibc in PRoot, `aarch64-unknown-linux-gnu`). Includes launch/bind contracts, artifact exchange, toolchain boundary rules, and evidence/validation handoff.

## Responsibilities

- Define and maintain host↔guest interface contracts (entrypoints, env, mounts, paths).
- Prevent ABI/binary/environment mixing across layers.
- Coordinate dependency ordering where host and guest concerns intersect.
- Track shared validation gates and rollback boundaries.

## Interface areas

| Area | Owner (primary) | Counterpart | Contract artifacts | Status |
|---|---|---|---|---|
| PRoot launch & bind mounts | termux | ubuntu | launch args, bind table, env allow/deny list | pending-unfetched (R06, R12-R18) |
| Exec/shebang/path translation | termux | ubuntu | shim behavior notes, script conventions | pending-unfetched (R03, R06) |
| Storage/artifact exchange | both | both | shared path policy, provenance/labeling per layer | pending |
| Toolchain target routing | both | both | per-triple build placement, linker/sysroot matrix | pending (R07-R09, manifests) |
| ABI/glibc boundary | ubuntu-sensitive | termux | allowed interfaces, forbidden mixed-linkage cases | pending-unfetched (R05, R08) |
| Service/runtime control | ubuntu | termux (entry) | supervisor contract, logs, health signals | pending |
| GPU/userspace split | both | both | ICD/loader/env per layer, validation separation | pending-unfetched (R17/R18) |

## Scripts / automation placeholders

| Item | Purpose | Status | Location (planned) |
|---|---|---|---|
| Interface contract linter/checklist | Verify env/mount/path separation rules | pending | TBD |
| Artifact labeling/provenance helper | Tag outputs with layer/triple/toolchain | pending | TBD |
| Cross-layer smoke tests | Validate launch, exec, file exchange, and boundaries | pending (on-device) | TBD |

## Dependency ordering notes

- Cross-layer contracts must be defined before dependent guest/toolchain/GPU phases proceed (see Phases 4-6, 13-15, 17-18).
- Any change to binds, exec shims, loaders, or env propagation requires re-validation on both sides.
- See: `../../04-dependency-manifests/global-dependency-dag.md` and all per-domain manifests.

## "Do-not-mix" summary (cross-cutting)

- **Triples:** `aarch64-linux-android` (host) vs `aarch64-unknown-linux-gnu` (guest) — never conflated.
- **Builds:** Android/Termux on host (NDK/LLD); Linux targets in guest (mold where supported).
- **Runtime:** Bionic libs/loader isolated from glibc libs/loader.
- **Config/env:** host-scoped vs guest-scoped activation; no shared `LD_LIBRARY_PATH` leakage.
- **Validation:** on-device results recorded with explicit layer attribution.

## Escalation / open decisions

- Mirror-driven layout/naming may relocate contracts (see `00-intake/conductor-alignment.md`).
- ABI boundary cases involving R05/R08 require evidence-backed decisions before adoption.
- Shared-storage execution policy (if binaries/scripts are exchanged) must prevent mixed-ABI execution.
