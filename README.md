# StressTester
Stress testing(DOS) setup via Apache Benchmark

# Versions
```python
Terraform 1.6.5
Ansible 2.15.6
Python 3.11.2
Debian 6.1.0-14 6.1.64-1
```

# Terraform
## Yandex
[Official manual](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart#configure-terraform)
1. Download terraform from hashicorp and ```export PATH=$PATH:/path/to/terraform```
2. Create an authorized key
```bash
   yc iam key create \
  --service-account-id <service_account_ID> \
  --folder-name <name_of_folder_with_service_account> \
  --output key.json
```
3. Add creds to environment
```bash
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
```
4. Create terraform config file
```bash
nano ~/.terraformrc

provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```

## VK

## Ansible

Installation
```bash
python3 -m pip install --user ansible
```
