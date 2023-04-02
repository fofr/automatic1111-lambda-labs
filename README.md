# Run Automatic1111 on Lambda Labs

This script assumes you are running on a VM without any persistent filesystem. It’s a cold start that installs everything.

## Deploy and run

```
./deploy_and_run.sh <ip_address>
```

- copies run.sh and config.json
- executes run.sh

Run will download:

- Automatic1111
- Controlnet extension and all models
- text2video deforum extension and models
- regional prompter extension
- Deliberate v2 from Civitai

It then starts `webui.sh` with the `--share` option

## Export outputs

```
./export-outputs.sh <ip_address>
```

Run in the background to frequenty rsync any generations back to your local machine.

Will attempt to rsync every 10 seconds, will stop on error (like if the instance is terminated).
