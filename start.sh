xhost +local:docker

sudo docker run -it --rm \
--name julia_docker \
-p 8888:8888 \
--net host \
--privileged \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
feltro/julia-rl

# -v /home/felusiani/Projects/Docker/JuliaRL:/root/JuliaRL \

