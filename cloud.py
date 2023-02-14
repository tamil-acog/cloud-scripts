import random
import typer
import os
import logging
import pathlib
import json


main_dir = pathlib.Path(__file__).parent.resolve()
app = typer.Typer()
logging.basicConfig(level="INFO")
shell_s = os.path.dirname(os.path.abspath(__file__))


@app.command()
def upload(storage_id: str, directory: str) -> None:
    if not os.path.isabs(directory):
        logging.info("The path you entered is not absolute. Please enter again")
        exit()
    logging.info("Uploading the package.....")
    try:
        os.system(f"/bin/bash {shell_s}/upload.sh {storage_id} {directory} {main_dir}")
    except Exception as e:
        logging.info("Error while uploading the package. Please try again")


@app.command()
def download(storage_id: str, directory: str, project_id: str) -> None:
    try:
        os.system(f"/bin/bash {shell_s}/download.sh {storage_id} {directory} {project_id} {main_dir}")
    except Exception as e:
        logging.info("Error while uploading the package. Please try again")


@app.command()
def run(storage_id: str, project_id: str, docker_image: str, command: str, machine: str) -> None:
    os.chdir(main_dir)
    variable = {}
    variable['user_input'] = {"storage_id": storage_id, "project_id": project_id, "docker_image": docker_image, "command": command, "machine_type": machine}
    variable['server_type'] = machine
    variable['machine_name'] = storage_id + str(random.randint(1, 100))
    variable['ip_name'] = storage_id + str(random.randint(101, 200))
    variable['ssh_key_name'] = storage_id + str(random.randint(201, 300))
    json_object = json.dumps(variable, indent = 4)
    with open("variables.tfvars.json", "w") as f:
        f.write(json_object)
    try:
        os.system(f"/bin/bash {shell_s}/terraform.sh {storage_id} {project_id} {docker_image} {command} {machine} {main_dir}")
    except Exception as e:
        logging.info("Error while executing the command. Please try again")


def main():
    app()


if __name__ == "__main__":
    app()