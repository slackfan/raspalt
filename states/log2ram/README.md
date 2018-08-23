# log2ram

This states allow to enable [log2ram](https://github.com/azlux/log2ram/) which aims to increase the lifetime of SSDs a Raspian is normally running on.

## Usage

```bash
#!/bin/bash
# Enable log2ram
salt '*' state.apply log2ram.configured
# Or
salt '*' state.apply log2ram.configured pillar='{"raspalt:log2ram:enabled": True}'
# Disable log2ram
salt '*' state.apply log2ram.configured pillar='{"raspalt:log2ram:enabled": False}'
```
