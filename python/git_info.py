"""
file-name:          2_git_info.py
file-uuid:          5582b180-b102-47b6-a9a0-943c73a80944
author:             Andreas Häberle
project-name:       ushell
project-uuid:       "f9c9a6c2-666d-4399-85f8-9e04c5bb2f99"
description:        human tools for the shell 
"""
import subprocess
from rich.console import Console
from rich.table import Table

console = Console()

def get_remotes():
    result = subprocess.run(['git', 'remote', '-v'], capture_output=True, text=True)
    return result.stdout.strip().split('\n')

def get_branches():
    result = subprocess.run(['git', 'branch', '-a'], capture_output=True, text=True)
    return result.stdout.strip().split('\n')

def main():
    console.print("# Git Info", style="bold underline")

    console.print("## Remotes", style="bold")
    remotes = get_remotes()
    for remote in remotes:
        console.print(remote)

    console.print("\n## Branches", style="bold")
    branches = get_branches()
    for branch in branches:
        console.print(branch)

if __name__ == "__main__":
    main()