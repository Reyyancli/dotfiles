#!/usr/bin/env python3


def main(direction: int):
    import json
    import subprocess

    workspaces_bytes = subprocess.check_output(["bash", "-c", "niri msg -j workspaces"])
    workspaces = json.loads(workspaces_bytes)

    focused_workspace = next(
        (x for x in workspaces if "is_focused" in x and x["is_focused"])
    )
    if not focused_workspace:
        return
    if "idx" not in focused_workspace:
        return

    target_workspace = next(
        (
            x
            for x in workspaces
            if "idx" in x and x["idx"] == focused_workspace["idx"] + direction
        ),
        None,
    )
    if not target_workspace:
        sorted_workspaces = sorted(workspaces, key=lambda x: x["idx"], reverse=True)
        if not sorted_workspaces:
            return
        target_workspace = sorted_workspaces[0] if direction < 0 else sorted_workspaces[-1]

    if not target_workspace:
        return

    target_workspace_identifier = target_workspace["name"]
    if not target_workspace_identifier:
        target_workspace_identifier = target_workspace["idx"]

    subprocess.run(
        ["bash", "-c", f"niri msg action focus-workspace {target_workspace_identifier}"]
    )


if __name__ == "__main__":
    import sys

    if len(sys.argv) >= 2:
        direction = 1 if sys.argv[1] == "next" else -1
        main(direction)
