[![Open in Codespaces](https://classroom.github.com/assets/launch-codespace-2972f46106e565e64193e422d61a12cf1da4916b45550586e14ef0a7c637dd04.svg)](https://classroom.github.com/open-in-codespaces?assignment_repo_id=23143238)
[![Autograding Tests](https://github.com/CSSE6400/2026-p4-keys-i/actions/workflows/classroom.yml/badge.svg)](https://github.com/CSSE6400/2026-p4-keys-i/actions/workflows/classroom.yml)

# CSSE6400 Week 4 Practical

Deploying the [Hextris](https://hextris.io/) web game to an AWS EC2 instance using Terraform for CSSE6400 Week 4 Practical.

## Description

This project provisions a simple web server on AWS and deploys Hextris to it automatically using Terraform and EC2 `user_data`.

The practical demonstrates how to:

- configure the AWS provider in Terraform
- create a security group for HTTP and SSH access
- launch an EC2 instance
- bootstrap the instance to install Apache and deploy Hextris
- validate the Terraform configuration with the provided unit tests
- deploy and destroy infrastructure safely

This repository is intended for the CSSE6400 Week 4 practical and follows the structure expected by the supplied test suite.

## Features

- Terraform-based AWS infrastructure
- Automated Hextris deployment on EC2
- Security group configuration for HTTP and SSH
- Unit tests for required Terraform resources
- Simple deployment and cleanup workflow

## Requirements

Before running this project, make sure you have:

- Python 3.12
- Pipenv
- Terraform
- AWS account access
- AWS credentials saved in a local `./credentials` file

## Installation

This project works best when Pipenv creates the virtual environment inside the project directory.

Set these environment variables before installing dependencies:

```bash
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_IGNORE_VIRTUALENVS=1
```

Then create the environment and install packages:

```bash
pipenv --python 3.12
pipenv install
```

This creates a local `.venv` directory, which makes the test runner work without extra setup.

## Usage

### Run the tests

Use the provided test script:

```bash
.csse6400/bin/unittest.sh
```

If needed, run it after exporting the Pipenv variables:

```bash
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_IGNORE_VIRTUALENVS=1
.csse6400/bin/unittest.sh
```

You can also run the tests directly with:

```bash
pipenv run python3 -m unittest discover -s tests
```

### Initialise Terraform

Before deploying infrastructure, initialise Terraform:

```bash
terraform init
```

### Deploy the project

To create the AWS resources and deploy Hextris:

```bash
terraform apply
```

Terraform will display a plan and ask for confirmation. Type `yes` to continue.

Once complete, Terraform should output the EC2 instance public IP. Open that IP address in a browser to view Hextris.

### Destroy the project

To remove all provisioned resources:

```bash
terraform destroy
```

Type `yes` when prompted.

## Project Structure

```bash
2026-p4-keys-i
├── Pipfile             # dependency management
├── Pipfile.lock
├── README.md
├── main.tf             # terrform config files
├── serve-heutrix.sh    # deploy heutrix on instance
└── tests               # unit tests
```

> [!NOTE]
> the provided tests are strict about how the EC2 startup script is defined.  
> To pass the tests, the bash script for instance setup should be hardcoded directly in the Terraform configuration as `user_data`, rather than being loaded from a separate file or built indirectly.
> A slightly more explicit version:

## Author and Acknowledgment

Created for **CSSE6400 Week 4 Practical**.

Hextris is developed by the original Hextris project contributors:
[https://hextris.io/](https://hextris.io/)

## License

This repository is for educational use as part of university coursework.

## Project Status

This project is complete for the Week 4 practical requirements.
