#!/usr/bin/env python3
"""
Security check: verify SCALR_TOKEN (agent task token) permissions via curl-style requests.

Run as a hook in a run so SCALR_TOKEN and SCALR_HOSTNAME are set.

1) Current account (SCALR_HOSTNAME): GETs outside agent task permissions
   (other env, other workspace, other run) — expect 403/404.
2) Other account (OTHER_ACCOUNT_HOST): GETs with same token — expect 403/401
   (no cross-account access).

Required env vars from the run:
  SCALR_TOKEN, SCALR_HOSTNAME

Current account (IDs from this account; for “outside scope” tests; provide real IDs from the same account):
  OTHER_ENV_ID, OTHER_WORKSPACE_ID,
  OTHER_RUN_ID

Other account (host + IDs from that account):
  OTHER_ACCOUNT_HOST (default: mmoh-goo.main.scalr.dev)
  OTHER_ACC_ENV_ID, OTHER_ACC_WORKSPACE_ID, OTHER_ACC_RUN_ID
"""

from __future__ import annotations

import os
import sys
from urllib.parse import urljoin

try:
    import requests
except ImportError:
    print("Need: pip install requests", file=sys.stderr)
    sys.exit(1)

# JSON:API
CONTENT_TYPE = "application/vnd.api+json"
API_PREFIX = "/api/iacp/v3"


def env(name: str, default: str | None = None) -> str | None:
    v = os.environ.get(name)
    return v if (v and v.strip()) else default


def build_curl(method: str, url: str, token: str, extra_headers: dict[str, str] | None = None) -> str:
    parts = ["curl", "-s", "-S", "-X", method, "-H", f"Accept: {CONTENT_TYPE}"]
    if token:
        parts += ["-H", '"Authorization: Bearer $SCALR_TOKEN"']
    if extra_headers:
        for k, v in extra_headers.items():
            parts += ["-H", f'"{k}: {v}"']
    parts.append(f'"{url}"')
    return " \\\n  ".join(parts)


def run_request(
    method: str,
    base_url: str,
    path: str,
    token: str,
    label: str,
    extra_headers: dict[str, str] | None = None,
) -> None:
    url = urljoin(base_url + "/", path.lstrip("/"))
    headers = {"Accept": CONTENT_TYPE}
    if token:
        headers["Authorization"] = f"Bearer {token}"
    if extra_headers:
        headers.update(extra_headers)

    curl_cmd = build_curl(method, url, token, extra_headers)
    print(f"\n--- {label} ---")
    print("CURL (use SCALR_TOKEN from env):")
    print(curl_cmd)
    print()

    try:
        r = requests.request(
            method,
            url,
            headers=headers,
            timeout=30,
            verify=True,
        )
    except Exception as e:
        print(f"RESPONSE (error): {e}")
        return

    print(f"HTTP {r.status_code}")
    for k, v in r.headers.items():
        print(f"  {k}: {v}")
    print("BODY:")
    try:
        print(r.text[:4096] if r.text else "(empty)")
        if len(r.text or "") > 4096:
            print("... [truncated]")
    except Exception:
        print(r.content[:4096] if r.content else "(empty)")


def main() -> None:
    token = env("SCALR_TOKEN")
    hostname = env("SCALR_HOSTNAME")
    other_host = env("OTHER_ACCOUNT_HOST", "mmoh-goo.main.scalr.dev")

    if not token or not hostname:
        print("Set SCALR_TOKEN and SCALR_HOSTNAME (e.g. from run env).", file=sys.stderr)
        sys.exit(1)

    scheme = "https"
    current_base = f"{scheme}://{hostname}{API_PREFIX}"
    other_base = f"{scheme}://{other_host}{API_PREFIX}"

    # Current account: IDs from THIS account (another env/ws/run) — token must not access
    curr_other_env_id = env("OTHER_ENV_ID")
    curr_other_workspace_id = env("OTHER_WORKSPACE_ID")
    curr_other_run_id = env("OTHER_RUN_ID")

    # Other account: IDs from the OTHER account — token must not access cross-account
    other_acc_env_id = env("OTHER_ACC_ENV_ID")
    other_acc_workspace_id = env("OTHER_ACC_WORKSPACE_ID")
    other_acc_run_id = env("OTHER_ACC_RUN_ID")

    # Optional: current run's scope (within permissions) — from run env
    current_workspace_id = env("SCALR_WORKSPACE_ID")
    current_env_id = env("SCALR_ENVIRONMENT_ID")
    current_run_id = env("SCALR_RUN_ID")

    print("=== Agent task token permission check ===")
    print(f"Current account: {hostname}")
    print(f"Other account:  {other_host}")
    print(f"Token present:  yes (len={len(token)})")

    # --- Current account: requests OUTSIDE agent task permissions (expect 403/404) ---
    print("\n" + "=" * 60)
    print("CURRENT ACCOUNT — GETs outside agent task permissions")
    print("(expect 403 Forbidden or 404 Not Found)")
    print("=" * 60)

    if curr_other_env_id:
        run_request(
            "GET",
            current_base,
            f"/environments/{curr_other_env_id}",
            token,
            f"GET another env (current account, outside scope): /environments/{curr_other_env_id}",
        )
    else:
        print("\n--- GET another environment (current account) ---")
        print("Set OTHER_ENV_ID (ID from current account). Skipped.")

    if curr_other_workspace_id:
        run_request(
            "GET",
            current_base,
            f"/workspaces/{curr_other_workspace_id}",
            token,
            f"GET another workspace (current account, outside scope): /workspaces/{curr_other_workspace_id}",
        )
    else:
        print("\n--- GET another workspace (current account) ---")
        print("Set OTHER_WORKSPACE_ID (ID from current account). Skipped.")

    if curr_other_run_id:
        run_request(
            "GET",
            current_base,
            f"/runs/{curr_other_run_id}",
            token,
            f"GET another run (current account, outside scope): /runs/{curr_other_run_id}",
        )
    else:
        print("\n--- GET another run (current account) ---")
        print("Set OTHER_RUN_ID (ID from current account). Skipped.")

    # List runs (agent task has runs_create_configuration_changes but list may be scoped)
    run_request(
        "GET",
        current_base,
        "/runs?page[size]=2",
        token,
        "GET /runs list (check scope)",
    )

    # List environments (agent task has no account/env list permission)
    run_request(
        "GET",
        current_base,
        "/environments?page[size]=2",
        token,
        "GET /environments list (no permission for agent task)",
    )

    # --- Current account: request WITHIN permissions (optional; expect 200) ---
    if current_workspace_id:
        run_request(
            "GET",
            current_base,
            f"/workspaces/{current_workspace_id}",
            token,
            f"GET current run workspace (in scope): /workspaces/{current_workspace_id}",
        )
    if current_run_id:
        run_request(
            "GET",
            current_base,
            f"/runs/{current_run_id}",
            token,
            f"GET current run (in scope): /runs/{current_run_id}",
        )

    # --- Other account: same token, different host; use IDs FROM that account (expect 403/401) ---
    print("\n" + "=" * 60)
    print("OTHER ACCOUNT — same token, host + IDs from other account (expect 403/401)")
    print("=" * 60)

    run_request(
        "GET",
        other_base,
        "/accounts",
        token,
        f"GET /accounts on {other_host}",
    )
    run_request(
        "GET",
        other_base,
        "/environments?page[size]=2",
        token,
        f"GET /environments list on {other_host}",
    )
    run_request(
        "GET",
        other_base,
        "/workspaces?page[size]=2",
        token,
        f"GET /workspaces list on {other_host}",
    )
    run_request(
        "GET",
        other_base,
        "/runs?page[size]=2",
        token,
        f"GET /runs list on {other_host}",
    )

    if other_acc_env_id:
        run_request(
            "GET",
            other_base,
            f"/environments/{other_acc_env_id}",
            token,
            f"GET env by ID from other account: /environments/{other_acc_env_id}",
        )
    else:
        print("\n--- GET environment by ID (other account) ---")
        print("Set OTHER_ACC_ENV_ID (ID from other account). Skipped.")

    if other_acc_workspace_id:
        run_request(
            "GET",
            other_base,
            f"/workspaces/{other_acc_workspace_id}",
            token,
            f"GET workspace by ID from other account: /workspaces/{other_acc_workspace_id}",
        )
    else:
        print("\n--- GET workspace by ID (other account) ---")
        print("Set OTHER_ACC_WORKSPACE_ID (ID from other account). Skipped.")

    if other_acc_run_id:
        run_request(
            "GET",
            other_base,
            f"/runs/{other_acc_run_id}",
            token,
            f"GET run by ID from other account: /runs/{other_acc_run_id}",
        )
    else:
        print("\n--- GET run by ID (other account) ---")
        print("Set OTHER_ACC_RUN_ID (ID from other account). Skipped.")

    print("\n=== Done ===")


if __name__ == "__main__":
    main()
