variable "save_to" {
    default = ""
}

data "archive_file" "generate_zip" {
  type        = "zip"
  output_path = (var.save_to != "" ? "${var.save_to}/orm-graph-stack.zip" : "${path.module}/dist/orm-graph-stack.zip")
  source_dir = "../terraform"
  excludes    = ["packer",".terraform.lock.hcl","terraform.tfstate", "terraform.tfvars.template", "terraform.tfvars", "provider.tf", ".terraform", "build-orm", "images", "README.md", "terraform.", "terraform.tfstate.backup", "test", "simple", ".git", "README", ".github", ".gitignore", ".DS_Store", "LICENSE","diagram",]
}