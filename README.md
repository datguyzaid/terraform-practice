# Terraform Commands Cheat Sheet

A concise, comprehensive guide to essential Terraform commands for managing infrastructure as code. These commands assume Terraform is installed and executed from a directory with `.tf` configuration files. 
---

## Core Workflow Commands

### **Initialization**
- **`terraform init`**  
  Sets up a working directory by downloading providers and modules, and configuring the backend.
- **`terraform init -upgrade`**  
  Upgrades providers and modules to the latest compatible versions.
- **`terraform init -backend-config="dev.tfbackend" -migrate-state`**  
  Initializes with a backend config file (e.g., `dev.tfbackend`) and migrates existing state.
- **`terraform init -backend-config="region=us-east-2" -migrate-state`**  
  Initializes with inline backend config (e.g., region) and migrates state.

### **Formatting & Validation**
- **`terraform fmt`**  
  Standardizes the style of `.tf` files in the current directory.
- **`terraform fmt -recursive`**  
  Formats all `.tf` files recursively in subdirectories.
- **`terraform validate`**  
  Checks syntax and configuration validity without contacting remote services.

### **Planning**
- **`terraform plan`**  
  Previews changes Terraform will make to match the desired state.
- **`terraform plan -out=tfplan`**  
  Saves the execution plan to a file (e.g., `tfplan`) for later use.
- **`terraform plan -destroy`**  
  Previews resources to be destroyed (dry-run for destruction).
- **`terraform plan -var="aws_region=us-east-1"`**  
  Previews with a specific variable value.

### **Applying Changes**
- **`terraform apply`**  
  Executes changes to reach the desired state, with a confirmation prompt.
- **`terraform apply -auto-approve`**  
  Applies changes without prompting for confirmation.
- **`terraform apply tfplan`**  
  Executes a saved plan (e.g., `tfplan`) without prompting.
- **`terraform apply -var-file="dev.tfvars"`**  
  Applies changes using variables from a `.tfvars` file.

### **Destroying Resources**
- **`terraform destroy`**  
  Removes all managed resources, with a confirmation prompt.
- **`terraform destroy -auto-approve`**  
  Destroys resources without prompting.
- **`terraform apply -destroy`**  
  Alternative to `terraform destroy`, with a prompt.
- **`terraform apply -destroy -auto-approve`**  
  Destroys resources without prompting.

---

## State Management Commands

- **`terraform state list`**  
  Lists all resources tracked in the current state file.
- **`terraform state show <resource>`**  
  Displays details of a specific resource (e.g., `aws_instance.example`).
- **`terraform state rm <resource>`**  
  Removes a resource from the state file without deleting it from the provider.
- **`terraform state mv <source> <destination>`**  
  Moves a resource in the state file (e.g., for refactoring).

---

## Output Commands

- **`terraform output`**  
  Displays all defined outputs from the state file.
- **`terraform output <key>`**  
  Shows the value of a specific output (e.g., `terraform output instance_ip`).
- **`terraform output -raw`**  
  Outputs raw values without formatting.
- **`terraform output -json`**  
  Outputs all values in JSON format.

---

## Inspection Commands

- **`terraform show`**  
  Displays the current state in a human-readable format.
- **`terraform show tfplan`**  
  Shows details of a saved plan file (e.g., `tfplan`).
- **`terraform providers`**  
  Lists all providers used in the configuration.

---

## Variable Handling

- **`terraform apply -var="key=value"`**  
  Passes a variable directly (e.g., `-var="aws_region=us-east-1"`).
- **`terraform apply -var-file="filename.tfvars"`**  
  Uses variables from a `.tfvars` file (e.g., `dev.tfvars`).
- **`terraform plan -var="key=value" -out=tfplan`**  
  Plans with variables and saves the output.

---

## Meta-Arguments

- **`depends_on`**  
  Explicitly defines resource dependencies (e.g., `depends_on = [aws_instance.example]`).
- **`count`**  
  Creates multiple instances of a resource (e.g., `count = 3`).
- **`for_each`**  
  Creates resources dynamically from a map or set (e.g., `for_each = var.subnets`).
- **`provider`**  
  Specifies a provider alias for a resource (e.g., `provider = aws.west`).
- **`lifecycle`**  
  Customizes resource behavior:  
  - `create_before_destroy = true`  
    Creates a new resource before destroying the old one.  
  - `prevent_destroy = true`  
    Blocks destruction of the resource.  
  - `ignore_changes = [attribute]`  
    Ignores changes to specified attributes (e.g., `ignore_changes = [tags]`).  
  - `replace_triggered_by = [resource]`  
    Replaces the resource if a referenced item changes.

---

## Advanced Commands

- **`terraform import <resource> <id>`**  
  Imports an existing resource into the state (e.g., `terraform import aws_instance.example i-12345678`).
- **`terraform taint <resource>`**  
  Marks a resource as tainted, forcing replacement on the next apply (e.g., `terraform taint aws_instance.example`).
- **`terraform untaint <resource>`**  
  Removes the tainted status from a resource.
- **`terraform refresh`**  
  Updates the state file to match the real-world infrastructure without applying changes.
- **`terraform workspace list`**  
  Lists all workspaces in the current configuration.
- **`terraform workspace new <name>`**  
  Creates a new workspace (e.g., `terraform workspace new dev`).
- **`terraform workspace select <name>`**  
  Switches to an existing workspace (e.g., `terraform workspace select prod`).

---

## Example Workflow

1. **Initialize**: `terraform init -upgrade`  
2. **Format**: `terraform fmt -recursive`  
3. **Validate**: `terraform validate`  
4. **Plan**: `terraform plan -out=tfplan`  
5. **Apply**: `terraform apply tfplan`  
6. **Inspect**: `terraform output`  
7. **Destroy (if needed)**: `terraform destroy -auto-approve`

---

## Tips & Notes

- Replace `tf` with `terraform` unless `tf` is aliased in your shell.
- Use `-auto-approve` cautiously—it skips confirmation and applies changes immediately.
- Ensure backend access (e.g., AWS S3, Terraform Cloud) and appropriate permissions.
- Combine commands with variables (e.g., `-var`, `-var-file`) for flexibility.
- Check `terraform version` to confirm your installed version.

Happy Terraforming! 🚀