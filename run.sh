xhost +local:root

XAUTH=/tmp/.docker.xauth

docker run -it \
    --env="DISPLAY=unix$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$XAUTH:$XAUTH" \
    --volume="$(pwd):/ORB_SLAM2/" \
    --net=host \
    --privileged \
    --gpus all \
    tokohsun/orb-slam2:ubuntu1804-cudagl11  \
    /bin/bash

echo "Done!!"


#$ docker run -v ~/docker/ORB_SLAM2/:/ORB_SLAM2/ -w=/ORB_SLAM2/ proudh/docker-orb-slam2-build /bin/bash -c ./build.sh