import subprocess
import sys

def run_command(command):
    """Run a shell command and stream the output."""
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    for line in process.stdout:
        print(line.decode(), end="")
    for line in process.stderr:
        print(line.decode(), end="")
    process.wait()
    if process.returncode != 0:
        print(f"Command failed with exit code {process.returncode}")
        sys.exit(process.returncode)

def main():
    try:
        print("Initializing Terraform...")
        run_command('terraform init')

        print("Validating Terraform configuration...")
        run_command('terraform validate')

        print("Creating Terraform plan...")
        run_command('terraform plan -out=tfplan')

        print("Applying Terraform configuration...")
        run_command('terraform apply -auto-approve tfplan')

        print("Terraform operation completed successfully.")
    except Exception as e:
        print(f"An error occurred: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
