#!/bin/bash

# install A1111's stable-diffusion-webui
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

cd stable-diffusion-webui
git checkout a9fed7c
cd ..

# install extensions
git clone https://github.com/hako-mikan/sd-webui-regional-prompter.git stable-diffusion-webui/extensions/sd-webui-regional-prompter
git clone https://github.com/Mikubill/sd-webui-controlnet.git stable-diffusion-webui/extensions/sd-webui-controlnet
git clone https://github.com/deforum-art/sd-webui-modelscope-text2video.git stable-diffusion-webui/extensions/sd-webui-modelscope-text2video
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui-aesthetic-gradients stable-diffusion-webui/extensions/stable-diffusion-webui-aesthetic-gradients

# install Deliberate v2
wget --trust-server-names --no-verbose --content-disposition -O deliberate_v2.safetensors "https://civitai.com/api/download/models/15236?type=Model&format=SafeTensor"
mv deliberate_v2.safetensors stable-diffusion-webui/models/Stable-diffusion/deliberate_v2.safetensors

# move config
mv config.json stable-diffusion-webui/config.json

# install Controlnet models and t2iadapters
# https://github.com/TheLastBen/fast-stable-diffusion/blob/main/AUTOMATIC1111_files/CN_models.txt
TARGET_DIR="stable-diffusion-webui/extensions/sd-webui-controlnet/models"
URLS=(
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_canny-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_depth-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_hed-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_mlsd-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_normal-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_openpose-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_scribble-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_seg-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_canny-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_color-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_depth-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_keypose-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_openpose-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_seg-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_sketch-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_style-fp16.safetensors"
)

mkdir -p "$TARGET_DIR"
for url in "${URLS[@]}"; do
  wget --no-verbose -P "$TARGET_DIR" "$url"
done

# install ModelScope text2video models
TARGET_DIR="stable-diffusion-webui/models/ModelScope/t2v"
URLS=(
"https://huggingface.co/kabachuha/modelscope-damo-text2video-pruned-weights/resolve/main/VQGAN_autoencoder.pth"
"https://huggingface.co/kabachuha/modelscope-damo-text2video-pruned-weights/resolve/main/open_clip_pytorch_model.bin"
"https://huggingface.co/kabachuha/modelscope-damo-text2video-pruned-weights/resolve/main/text2video_pytorch_model.pth"
"https://huggingface.co/kabachuha/modelscope-damo-text2video-pruned-weights/resolve/main/configuration.json"
)

mkdir -p "$TARGET_DIR"
for url in "${URLS[@]}"; do
  wget --no-verbose -P "$TARGET_DIR" "$url"
done

# run webui
cd stable-diffusion-webui
./webui.sh --share --no-download-sd-model
