### Docker image for AI with Python 3.7

#### GPU-enabled and includes all the standard ML/DL stuff plus OpenCV

Based on a heavily modified fastai setup.

Build with: -

```
docker build -t ck/ai .
```

Run using: -

```
docker run --runtime=nvidia --device=/dev/video0:/dev/video0 --restart unless-stopped -d -v $HOME:/data/home -p 8888:8888 ck/ai:latest
```

Or omit the --device parameter if webcam forwarding is not required.
