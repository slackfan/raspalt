# timesyncd

This states allow to enable the Systemd Timesyncd daemon with optionally a custom list of time servers.

## Usage

```bash
#!/bin/bash
salt '*' state.apply timesyncd.enabled
# with custom time server
salt '*' state.apply timesyncd.enabled pillar='{"raspalt:timesyncd:timeserver": ["server1", "server2"]}'
```
