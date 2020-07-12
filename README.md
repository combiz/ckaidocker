### Docker image for AI

#### GPU-enabled Jupyter Lab with Tensorflow/PyTorch/Keras/OpenCV

Build with: -

```
docker build -f dockerfile -t ckai .
```

Run using: -

```
docker run --gpus all --device=/dev/video0:/dev/video0 --restart unless-stopped -d -v $HOME:/data/home -p 8888:8888 ckai:latest
```

Or omit the --device parameter if webcam forwarding is not required.

### Versions as of 07/2020
`nvidia-smi`

| app/package | version    |
| ----------- |:----------:|
| nvidia-smi  | 450.51.05  |
| driver      | 450.51.05  |
| CUDA        | 11.0       |

`nvcc --version`
cuda compilation tools, release 10.2, V10.2.89

`python package.__version__`

| app/package | version |
| ----------- |:-------:|
| tensorflow  | 2.2.0   |
| torch       | 1.5.1   |
| keras       | 2.3.1   |
| cv2         | 4.3.0   |

torch.cuda.is_available() True
