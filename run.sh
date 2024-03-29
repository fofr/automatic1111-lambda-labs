#!/bin/bash

# install A1111's stable-diffusion-webui
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

# install extensions
git clone https://github.com/hako-mikan/sd-webui-regional-prompter.git stable-diffusion-webui/extensions/sd-webui-regional-prompter
git clone https://github.com/Mikubill/sd-webui-controlnet.git stable-diffusion-webui/extensions/sd-webui-controlnet
git clone https://github.com/Coyote-A/ultimate-upscale-for-automatic1111.git stable-diffusion-webui/extensions/ultimate-upscale-for-automatic1111
git clone https://github.com/kabachuha/sd-webui-text2video stable-diffusion-webui/extensions/sd-webui-text2video

# move config
mv config.json stable-diffusion-webui/config.json

# install Stable Diffusion models
TARGET_DIR="stable-diffusion-webui/models/Stable-diffusion"
URLS=(
"https://huggingface.co/XpucT/Deliberate/resolve/main/Deliberate_v2.safetensors"
"https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
"https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors"
)

for url in "${URLS[@]}"; do
  wget --no-verbose -P "$TARGET_DIR" "$url"
done

# install Controlnet models and t2iadapters
# https://github.com/TheLastBen/fast-stable-diffusion/blob/main/AUTOMATIC1111_files/CN_models.txt
TARGET_DIR="stable-diffusion-webui/extensions/sd-webui-controlnet/models"
URLS=(
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_full.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_mid.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_small.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_depth_full.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_depth_mid.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_depth_small.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/ioclab_sd15_recolor.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/ip-adapter_sd15.pth"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/ip-adapter_sd15_plus.pth"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/ip-adapter_xl.pth"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_blur.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_blur_anime.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_blur_anime_beta.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_canny.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_canny_anime.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_depth.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_depth_anime.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_openpose_anime.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_openpose_anime_v2.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_scribble_anime.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_canny_128lora.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_canny_256lora.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_depth_128lora.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_depth_256lora.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_recolor_128lora.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_recolor_256lora.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_sketch_128lora.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_sketch_256lora.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sargezt_xl_depth.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sargezt_xl_depth_faid_vidit.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sargezt_xl_depth_zeed.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sargezt_xl_softedge.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_canny.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_depth_midas.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_depth_zoe.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_lineart.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_openpose.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_sketch.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_xl_canny.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_xl_openpose.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_xl_sketch.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/thibaud_xl_openpose.safetensors"
"https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/thibaud_xl_openpose_256lora.safetensors"
"https://huggingface.co/monster-labs/control_v1p_sd15_qrcode_monster/resolve/main/control_v1p_sd15_qrcode_monster.safetensors"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_canny.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1p_sd15_depth.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_lineart.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_mlsd.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_normalbae.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_scribble.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_seg.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11e_sd15_ip2p.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11e_sd15_shuffle.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_inpaint.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_softedge.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15s2_lineart_anime.pth"
"https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1e_sd15_tile.pth"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_keypose-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_seg-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_sketch-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_depth-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_canny-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_color-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_style-fp16.safetensors"
"https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_openpose-fp16.safetensors"
)

mkdir -p "$TARGET_DIR"
for url in "${URLS[@]}"; do
  wget --no-verbose -P "$TARGET_DIR" "$url"
done

# install ModelScope text2video models
TARGET_DIR="stable-diffusion-webui/models/ModelScope/t2v"
URLS=(
"https://huggingface.co/kabachuha/modelscope-damo-text2video-pruned-weights/resolve/main/VQGAN_autoencoder.pth"
"https://huggingface.co/cerspense/zeroscope_v2_XL/resolve/main/zs2_XL/open_clip_pytorch_model.bin"
"https://huggingface.co/cerspense/zeroscope_v2_XL/resolve/main/zs2_XL/text2video_pytorch_model.pth"
"https://huggingface.co/kabachuha/modelscope-damo-text2video-pruned-weights/resolve/main/configuration.json"
)

mkdir -p "$TARGET_DIR"
for url in "${URLS[@]}"; do
  wget --no-verbose -P "$TARGET_DIR" "$url"
done

# TODO: Add videocrafter
# https://huggingface.co/kabachuha/videocrafter-pruned-weights/resolve/main/model.ckpt

# run webui manually
cd stable-diffusion-webui
./webui.sh --listen --port 7860 --no-download-sd-model
