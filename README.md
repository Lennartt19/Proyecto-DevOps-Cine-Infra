# Proyecto-DevOps-Cine-Infra

Infraestructura básica en Terraform (cuenta Azure for Students).

## Estructura (una carpeta por entorno, sintaxis simple)

```text
envs/
  dev/ (resource-group + aks + acr + keyvault)  → rg-cine-dev   (state: dev.tfstate)
  qa/  (solo resource-group por ahora)          → rg-cine-qa    (state: qa.tfstate)
  prod/(solo resource-group por ahora)          → rg-cine-prod  (state: prod.tfstate)
.github/workflows/terraform.yml → despliegue manual desde GitHub
```

Cada carpeta de env es independiente: provider + recursos con nombres fijos.
Sin `for_each`, sin módulos.

## Bootstrap de permisos (leer antes del primer apply tras un destroy)

Terraform corre como `mi-github-terraform` (solo `Contributor`), y
`Contributor` NO puede crear `roleAssignments` ni escribir secretos del vault.
Por eso existe 1 permiso manual que vive FUERA del state, colgado del RG:

```bash
RG_ID=$(az group show -n rg-cine-dev --query id -o tsv)

# El robot puede repartir llaves dentro de dev (sin esto, el apply da 403).
az role assignment create \
  --assignee-object-id 0667fe5a-4624-4dfe-a788-8f846e67ec72 \
  --assignee-principal-type ServicePrincipal \
  --role "User Access Administrator" \
  --scope "$RG_ID"
```

Orden memorizable: **`destroy` → re-otorgar bootstrap → `apply`**.
El `destroy` borra el RG y el permiso con él. Los roles `Secrets Officer`
(CD + humano) ya los crea el propio `apply` (ver `envs/dev/keyvault.tf).

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
