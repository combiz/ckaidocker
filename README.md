### Docker image for AI

#### GPU-enabled and includes all the standard ML/DL stuff plus OpenCV

Based on a heavily modified fastai setup.

Build with: -

```
docker build -f dockerfile -t ck:ai .
```

Run using: -

```
docker run --runtime=nvidia --device=/dev/video0:/dev/video0 --restart unless-stopped -d -v $HOME:/data/home -p 8888:8888 ck/ai:latest
```

Or omit the --device parameter if webcam forwarding is not required.

Note: environment.yml is currently using the pip `- tf-nightly-gpu` instead of conda `tensorflow-gpu` .  When TF2 is released conda10 will be officially supported.


### Versions as of 02/2019
`nvidia-smi`

| app/package | version |
| ----------- |:-------:|
| nvidia-smi  | 415.27  |
| driver      | 415.27  |
| CUDA        | 10.0    |

`nvcc --version`
cuda compilation tools, release 10.0, V10.0.130

`python package.__version__`

| app/package | version |
| ----------- |:-------:|
| tensorflow  | 1.13.0-dev20190208  |
| torch       | 1.0.1.post2  |
| keras       | 2.2.4    |
| cv2         | 4.0.0    |

torch.cuda.is_available() True
