# Terraform Commands Cheat Sheet

This document provides a quick reference for common Terraform commands used to initialize, validate, plan, apply, and destroy infrastructure configurations. All commands assume you have Terraform installed and are executed from a directory containing your Terraform configuration files (e.g., `.tf` files).

---

## Initialization Commands

- **`terraform init`**  
  Initializes a Terraform working directory by downloading provider plugins and setting up the backend.

- **`tf init -backend-config dev.tfbackend -migrate-state`**  
  Initializes Terraform with a specific backend configuration file (e.g., `dev.tfbackend`) and migrates the state to the new backend.

- **`tf init -backend-config=region=us-east-2 -migrate-state`**  
  Initializes Terraform with inline backend configuration (e.g., specifying a region) and migrates the state.

- **`tf init -upgrade`**  
  Upgrades provider plugins and modules to the latest compatible versions that match your configuration.

---

## Validation and Formatting

- **`terraform validate`**  
  Validates the syntax and configuration of your Terraform files without accessing remote services.

- **`terraform fmt`**  
  Rewrites Terraform configuration files to a canonical format and style (applies to the current directory).

- **`terraform fmt -recursive`**  
  Formats all Terraform configuration files recursively in the current directory and its subdirectories.

---

## Planning Commands

- **`terraform plan`**  
  Generates an execution plan describing what Terraform will do to achieve the desired state.

- **`terraform plan -out myplan`**  
  Generates an execution plan and saves it to a file named `myplan` for later use with `terraform apply`.

- **`terraform plan -destroy`**  
  Generates a plan showing what resources will be destroyed (dry-run for destruction).

---

## Applying Changes

- **`terraform apply`**  
  Applies the changes required to reach the desired state of the configuration. Prompts for confirmation unless specified otherwise.

- **`terraform apply myplan`**  
  Applies the changes from a previously saved plan file (`myplan`). Does **not** prompt for confirmation.

---

## Destroying Resources

- **`terraform apply -destroy`**  
  Destroys all resources managed by Terraform in the current configuration (same as `terraform destroy`).

- **`terraform apply -destroy -auto-approve`**  
  Destroys all resources without requiring confirmation.

- **`terraform destroy`**  
  Destroys all resources managed by Terraform (prompts for confirmation).

- **`terraform destroy -auto-approve`**  
  Destroys all resources without requiring confirmation.

---

## Inspecting State and Plans

- **`terraform show`**  
  Displays the current state file in a human-readable format.

- **`terraform show myplan`**  
  Displays the contents of a saved plan file (`myplan`) in a human-readable format.

- **`terraform state list`**  
  Lists all resources currently managed by Terraform in the state file.

---

## Notes
- Replace `tf` with `terraform` if you haven’t aliased `tf` to `terraform` in your shell.
- Ensure you have appropriate permissions and access to the backend (e.g., AWS S3, Terraform Cloud) when using backend configurations.
- Use `-auto-approve` with caution, as it skips confirmation prompts and applies changes immediately.

---

## Example Workflow
1. Initialize: `terraform init`
2. Format: `terraform fmt -recursive`
3. Validate: `terraform validate`
4. Plan: `terraform plan -out myplan`
5. Apply: `terraform apply myplan`
6. Destroy (if needed): `terraform destroy -auto-approve`

Happy Terraforming!