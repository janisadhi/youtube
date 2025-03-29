## use webhook to trigger cicd
> use ngrok to create ngrok tunnel to run local jenkins on internet and add the jenkins url to github webhook in respective repository . dont forgot to check GitHub hook trigger for GITScm polling during pipeline creation.

You can run `ngrok` in the background using `nohup` or `tmux/screen`. Here are a few ways to do it:

### 1. Using `nohup` 
```bash
nohup ngrok http 8080 > ngrok.log 2>&1 &
```
- This runs `ngrok` on port 8080 in the background.
- The output is saved to `ngrok.log`.
- The `&` at the end makes it run in the background.

