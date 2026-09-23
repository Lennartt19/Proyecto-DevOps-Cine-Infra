# Proyecto-DevOps-Cine-Infra

Infraestructura básica en Terraform (cuenta Azure for Students).

## Estructura (una carpeta por entorno, sintaxis simple)

```text
envs/
  dev/main.tf + backend.hcl    → crea rg-cine-dev   (state: dev.tfstate)
  qa/main.tf + backend.hcl     → crea rg-cine-qa    (state: qa.tfstate)
  prod/main.tf + backend.hcl   → crea rg-cine-prod  (state: prod.tfstate)
.github/workflows/terraform.yml → despliegue manual desde GitHub
```

Cada `main.tf` es independiente: provider + un solo `azurerm_resource_group`
con nombre fijo. Sin variables, sin `for_each`, sin módulos.

## Backend remoto

State en `stcinetfstate01` / container `tfstate`
(RG `rg-devops-student`). Cada entorno tiene su `key`:
`dev.tfstate`, `qa.tfstate`, `prod.tfstate`.

## Uso local (un entorno)

```bash
cd envs/dev
terraform init -backend-config=backend.hcl
terraform validate
terraform plan
terraform apply
```

## Uso desde GitHub (manual, con click)

1. `Actions > Terraform manual > Run workflow`.
2. Elige `environment`: `dev`, `qa` o `prod`.
3. Elige `action`: `plan` (ver), `apply` (crear), `destroy` (borrar).
4. `Run workflow`.

Secrets necesarios en el repo (los mismos del otro repo):
`AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`.
