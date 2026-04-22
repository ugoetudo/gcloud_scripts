# Spark WSL Install
Apache Spark Windows Subsystem for Linux (WSL) Install

## Download and Install Spark
* Open a new Linux terminal. Execute the following commands to download and install (extract) Spark:
    ```
    mkdir Ubuntu
    cd Ubuntu
    mkdir Downloads
    cd Downloads
    wget https://archive.apache.org/dist/spark/spark-3.1.1/spark-3.1.1-bin-hadoop2.7.tgz
    cd ..
    mkdir Programs
    tar -xvzf Downloads/spark-3.1.1-bin-hadoop2.7.tgz -C Programs
    ```
* Once installed, open your .bashrc file in the nano text editor by executing the following command:
    ```
    nano ~/.bashrc
    ```
* Scroll to the bottom using the down arrow and paste the following to define the SPARK_HOME environment variable. Don't forget to change YOU to your Windows username. Press *Ctrl+x*, *Shift+y*, and *Enter* to save:
    ```
    export SPARK_HOME="/mnt/c/Users/YOU/Ubuntu/Programs/spark-2.3.1-bin-hadoop2.7"
    ```
* I also recommend that you set the HADOOP_CONF_DIR environment variable so that you can start spark-shell using a yarn master. 
    ```
    export HADOOP_CONF_DIR=/home/hadoop/etc/hadoop
    ```    