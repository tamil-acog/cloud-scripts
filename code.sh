#!/bin/bash
mkdir -p /root/metadata
lshw -short > /root/metadata/machine_info.txt
uname -a >> /root/metadata/machine_info.txt
cat /etc/*-release >> /root/metadata/machine_info.txt
dpkg -l >> /root/metadata/machine_info.txt


echo "############################################################################################" >/root/metadata/metadata.txt
echo "                                 MACHINE HAS BEEN PROVISIONED                               " >>/root/metadata/metadata.txt
echo "############################################################################################">>/root/metadata/metadata.txt


sudo apt update
sudo apt install -y docker.io
sudo docker login -u nitesh -p guNagaNa1 dockerhub.aganitha.ai
#sudo docker pull dockerhub.aganitha.ai/atk/test
sudo docker pull "$3"

echo "#############################################################################################">>/root/metadata/metadata.txt
echo "                                DOCKER INSTALLATION COMPLETED AND LOGGED IN                  ">>/root/metadata/metadata.txt
echo "##############################################################################################">>/root/metadata/metadata.txt


chmod 400 ~/.ssh/id_rsa

rsync -avzP storagebox:/home/$1/$2/ /root/input/
chmod 777 /root/input/*
chmod 777 /root/input
echo "################################################################################################">>/root/metadata/metadata.txt
echo "                          SYNCED THE HCLOUD INPUT FOLDER TO THE REMOTE MACHINE                   ">>/root/metadata/metadata.txt
echo "#################################################################################################">>/root/metadata/metadata.txt

echo "####################################################################################################">>/root/metadata/metadata.txt
echo "                                RUNNING THE DOCKER CONTAINER                                          ">>/root/metadata/metadata.txt
echo "#####################################################################################################">>/root/metadata/metadata.txt

start=`date +%s`

sudo docker run --rm -v /root/input:/home/work --shm-size=15g --entrypoint '' --workdir /home/work "$3" /bin/bash -c "$4"
computation_pid=$!
while kill -0 $computation_pid 2> /dev/null; do
  sleep 1
done

end=`date +%s`
echo "###########################  TIME TAKEN TO RUN THE JOB  ##########################">>/root/metadata/metadata.txt
echo "Execution time was `expr $end - $start` seconds." >> /root/metadata/metadata.txt
echo "###################################################################################">>/root/metadata/metadata.txt


echo "###########################################################################################################">>/root/metadata/metadata.txt
echo "                          UPLOADING THE OUTPUT FOLDER                                                      ">>/root/metadata/metadata.txt
echo "############################################################################################################">>/root/metadata/metadata.txt


rsync -avzP /root/input/ storagebox:/home/$1/$2/

echo "############################################################################################################">>/root/metadata/metadata.txt
echo "                          SYNCING THE METADATA FOLDER                                                       ">>/root/metadata/metadata.txt
echo "#############################################################################################################">>/root/metadata/metadata.txt
echo "DONE"> /root/metadata/done.txt
rsync -avzP /root/metadata/ storagebox:/home/$1/$2/
































# #sync_folder_host_local "/root/input_folder/" "/home" "input_folder" "u332964-sub1@95.217.92.102"
# rsync -av -e 'ssh -p 23 -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no' u332964-sub1@95.217.92.102:/home/input_folder/ /root/input_folder/
# #rsync_command for input folder


# # run the pulled image
# sudo docker run -v /root/input_folder:/input_folder -v /root/output_folder:/output_folder dockerhub.aganitha.ai/atk/test
# #sudo docker run --rm -v /root/cloud-run-test:/home/acog/AAV1 --entrypoint '' dockerhub.aganitha.ai/gmxpbsa:0.2 /bin/bash -c './mdrun.sh'

# # rsync output_folder to storage box
# #sync_folder_local_host "/root/output_folder/" "/home" "output_folder" "u332964-sub1@95.217.92.102"
# rsync -avz -e 'ssh -p 23 -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' /root/output_folder/ u332964-sub1@95.217.92.102:/home/output_folder/






