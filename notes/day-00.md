# Day 0 - Workstation set-up

## What I did

- Checked which DevOps tools were already installed with a loop over `command -v`. 12 of 20 were present.
- Installed the missing eight: kind, helm, tflint, yq, trivy, hadolint, localstack, ansible.
- Confirmed Docker Desktop was running (v29.8.1) on a 16 GB Intel Mac and gave it 8 GB of memory.
- Wrote a kind config file by hand and created a three-node Kubernetes cluster (one control plane, two workers), then deleted it.
- Cleaned up Homebrew build tools and freed 13.6 GB.

## Problems I hit

1. `brew install tflint` failed with "No available formula", and because one name was wrong, brew installed none of the tools in that command.
2. Homebrew no longer provides ready-made packages for Intel Macs, so it started compiling from source. `yq` pulled in pandoc and ghc, and `ansible` was about to compile LLVM and Rust, which would have taken many hours.
3. After `pip install --user localstack`, the shell said `command not found: localstack`.
4. The kind docs example I found pinned the node image to Kubernetes v1.16.4 (from 2019) and had only one worker.
5. `kind create cluster` failed with "no such file or directory" for my config file.

## How I fixed them

1. Removed tflint from the brew command and installed it as a release binary from GitHub into `/usr/local/bin`.
2. Let brew finish helm, yq, trivy and hadolint, pressed Ctrl + C when it reached the ansible dependencies, and installed ansible with pip in about a minute. Ran `brew autoremove` and `brew cleanup --prune=all` afterwards.
3. pip had installed into `~/Library/Python/3.14/bin`, which was not on my PATH. Added it in `~/.zshrc` and ran `source ~/.zshrc`.
4. Deleted the `image:` lines so kind uses its own tested default, and added a second `- role: worker` entry.
5. The file was open in VS Code but never saved (white dot on the tab). Saved with Cmd + S and re-ran the command.

## Commands worth remembering

```bash
command -v <tool>            # is this tool installed, and where
brew search <word>           # find the right package name
df -h /                      # free disk space
echo $PATH                   # folders the shell searches for commands
source ~/.zshrc              # reload shell config without a new tab
chmod +x <file>              # make a downloaded binary executable
ls -la                       # list files including hidden ones
kind create cluster --name test --config kind-test.yaml
kubectl get nodes
kind delete cluster --name test
brew autoremove && brew cleanup --prune=all
```

## Lessons

- On an Intel Mac, prefer release binaries, pip or Docker images over Homebrew for tools that would compile from source.
- "Command not found" right after a successful install is usually a PATH problem.
- "No such file or directory": run `ls` and `pwd` before retrying.
- Before copying an example from docs, check which lines are actually needed and look at any version numbers in it.
