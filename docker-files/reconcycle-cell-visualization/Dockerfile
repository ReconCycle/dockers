FROM ghcr.io/reconcycle/ros-devel:kinetic 

RUN apt-get update && apt-get install -y software-properties-common curl

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# Download packages that are needed for compiling Kivy
RUN apt-get update && apt-get install -y \
    python-setuptools \ 
    python-pygame \
    python-opengl \
    python-gst0.10 \
    python-enchant \
    gstreamer0.10-plugins-good \
    python-dev \
    build-essential \
    python-pip \
    libgl1-mesa-dev \
    libgles2-mesa-dev \
    zlib1g-dev 

RUN pip install --upgrade numpy numpy-quaternion
RUN pip install --upgrade Cython==0.25.2
RUN add-apt-repository ppa:kivy-team/kivy
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update
RUN apt-get install -y gcc-4.9 libstdc++6
RUN pip install Kivy==1.10.0

    
WORKDIR /ros_ws/src

RUN git clone -b gal-devel https://github.com/ReconCycle/reconcycle_visualization.git
RUN git clone https://github.com/ReconCycle/vision_ros_integration.git

WORKDIR /ros_ws
RUN source /opt/ros/$ROS_DISTRO/setup.bash && catkin build

# Set the workspace variable
ENV ROS_WORKSPACE=/ros_ws

ENTRYPOINT ["/ros_entrypoint.sh"]
