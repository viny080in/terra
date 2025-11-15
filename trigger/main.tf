#Starter  main.tf
provider "azuredevops" {
  org_service_url       = var.org_service_url
  personal_access_token = var.pat
}

resource "azuredevops_project" "project" {
  name = "ExampleProject"
}

resource "azuredevops_git_repository" "repo" {
  project_id = azuredevops_project.project.id
  name       = "example-repo"
  initialization {
    init_type = "Clean"
  }
}

resource "azuredevops_build_definition" "pipeline" {
  project_id = azuredevops_project.project.id
  name       = "terraform-pipeline"

  repository {
    repo_type             = "TfsGit"
    repo_id               = azuredevops_git_repository.repo.id
    branch_name           = "refs/heads/main"
    yml_path              = "azure-pipelines.yml"
    clean                 = true
    checkout_submodules   = false
  }

  ci_trigger {
    use_yaml = true
  }

  pull_request_trigger {
    use_yaml = true
  }
}