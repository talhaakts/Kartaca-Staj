# Kartaca-Staj 2023

Çekirdekten Yetişenler Programı.

Bulut Mühendisi Görevi.

## Kurulum

Projeyi çalıştırabilmemiz için  [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)'a ihtiyacımız var. Aşşağıdaki gibi kurulumu gerçekleştiriniz.

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg


gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint


gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint


echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list


sudo apt update

sudo apt-get install terraform
```

## Projeyi Çalıştırma 

```bash 
#Gerekli kütüphanelerin kurulumu için terraform init çalıştırıyoruz.
terraform init

#Herhangi bir sorun var mı kontrol edebilmek için terraform plan çalıştırıyoruz

terraform plan
var.project
  Enter a value: 

#Herhangi bir hata almadıysak terraform apply ile kaynakları oluşturuyoruz.

terraform apply
var.project
  Enter a value: 

#Uygulamaya erişmek için terraform output ile erişebilir adres linkini alabiliriz.
terraform output
application_address = http://<gcp_lb_address>

#Curl komutu ile uygulamamıza istek göndererek döndüğü mesajı görebiliriz.
curl "http://<gcp_lb_address>"
Kartaca Staj 2023
```

## Kaynaklar 

Projeyi oluşturma aşamasında faydalandığım linkler.
[https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service]()

[https://developer.hashicorp.com/terraform/tutorials/kubernetes/kubernetes-provider](https://developer.hashicorp.com/terraform/tutorials/kubernetes/kubernetes-provider)

[https://antonputra.com/google/create-gke-cluster-using-terraform/#create-subnet-in-gcp-using-terraform]()

[https://stackoverflow.com/questions/59055395/can-i-automatically-enable-apis-when-using-gcp-cloud-with-terraform]()

[https://stackoverflow.com/questions/57843340/how-to-pass-gke-credential-to-kubernetes-provider-with-terraform,]()

[https://stackoverflow.com/questions/57843340/how-to-pass-gke-credential-to-kubernetes-provider-with-terraform]()

[https://medium.com/rockedscience/how-to-fully-automate-the-deployment-of-google-cloud-platform-projects-with-terraform-16c33f1fb31f]()
## 


