# Based on https://github.com/ReconCycle/docker_examples/blob/master/ros1_panda_sim/Dockerfile

# TODO make separate images for qbhand and panda

# Two step build process as one of the repositories is private. 
# https://vsupalov.com/build-docker-image-clone-private-repo-ssh-key/
# https://itnext.io/building-docker-images-from-private-git-repositories-using-ssh-login-433edf5a18f2

# Prerequirements: 
#  - Generate RSA key pair using: ssh-keygen -t rsa -f github_key
#  - Add github_key.pub to https://github.com/ReconCycle/panda_action_servers/settings/keys

# Step 1: Add private github_key to intermediate build to pull from private repository 

FROM ghcr.io/reconcycle/gazebo:kinetic as intermediate
RUN sudo apt install -yq openssh-client
WORKDIR /tmp
COPY github_key .
RUN chmod 600 github_key
RUN eval $(ssh-agent) && \
    ssh-add github_key && \
    ssh-keyscan -t rsa -H github.com >> /etc/ssh/ssh_known_hosts && \
    git clone -b ijs-devel git@github.com:ReconCycle/panda_action_servers.git
    
FROM ghcr.io/reconcycle/gazebo:kinetic

# Download packages that are needed for compiling the qb stuff
RUN apt update && apt install -y \
    ros-${ROS_DISTRO}-libfranka \
    ros-${ROS_DISTRO}-franka-ros \
    ros-${ROS_DISTRO}-rospy-message-converter \
    ros-${ROS_DISTRO}-effort-controllers \
    ros-${ROS_DISTRO}-joint-state-controller \
    ros-${ROS_DISTRO}-moveit \
    ros-${ROS_DISTRO}-moveit-commander \    
    ros-${ROS_DISTRO}-moveit-visual-tools \
    software-properties-common \
    ros-${ROS_DISTRO}-qb-hand

RUN pip install --upgrade numpy numpy-quaternion

RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update
RUN apt-get install -y gcc-4.9 libstdc++6
    
WORKDIR /ros_ws/src
COPY --from=intermediate /tmp/panda_action_servers panda_action_servers
RUN git clone https://github.com/ReconCycle/reconcycle_simulation.git
RUN git clone https://github.com/ReconCycle/reconcycle_visualization.git
RUN git clone https://github.com/smihael/panda_sim_hw.git	
RUN git clone https://bitbucket.org/qbrobotics/qbhand-ros.git
RUN git clone https://github.com/ReconCycle/gazebo_panda.git
RUN git clone https://github.com/orocos/orocos_kinematics_dynamics && cd orocos_kinematics_dynamics && git submodule update --init --recursive
RUN git clone https://github.com/ReconCycle/franka_panda_description

WORKDIR /ros_ws/src/robot_module_msgs
RUN git checkout tum-devel

WORKDIR /ros_ws/src/reconcycle_visualization
RUN git checkout 043cd9b4a9fb36248b1a3c8d1f1b93c5e17eb6c5


WORKDIR /ros_ws
RUN source /opt/ros/$ROS_DISTRO/setup.bash && catkin build

# Set the workspace variable
ENV ROS_WORKSPACE=/ros_ws

ENTRYPOINT ["/ros_entrypoint.sh"]

LABEL org.opencontainers.image.source=https://github.com/ReconCycle/dockers
