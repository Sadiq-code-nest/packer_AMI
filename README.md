## 🚀 **What is Packer?**

Packer is an **open-source image-building automation tool** created by HashiCorp.
It allows DevOps engineers to create identical machine images for:

* AWS AMI
* Docker
* VirtualBox
* VMware
* Azure
* GCP

### ✔ Why use Packer?

* Faster EC2 instance boot time
* Same image across Dev/QA/Prod
* Pre-installed dependencies
* Security-hardened Golden AMIs
* Perfect for Auto Scaling Groups
* Can be integrated with CI/CD (Jenkins, GitHub Actions, GitLab, etc.)

---

## 📁 **Project Structure**

```
.
├── Test-aws-packer.pkr.hcl      # Packer template file (HCL)
├── Test-aws-packer.json
└── README.md
```

---

## 🔑 **Variables File (Credentials)**

Create a file:

`credentials.auto.pkrvars.hcl`

```hcl
aws_access_key = "YOUR_AWS_ACCESS_KEY"
aws_secret_key = "YOUR_AWS_SECRET_KEY"
```

⚠️ **Never commit credentials to GitHub!**
Always ignore them using `.gitignore`.

---

## 🛠 **Commands to Run Packer**

### **1. Initialize Packer**

This installs plugins (amazon-ebs plugin, etc.)

```
packer init .
```

---

### **2. Format the file (optional but recommended)**

```
packer fmt .
```

---

### **3. Validate the template**

This checks if your HCL is correct:

```
packer validate .
```

---

### **4. Build the AMI**

Replace `<aws-ubuntu.pkr.hcl>` with your filename:

```
packer build aws-ubuntu.pkr.hcl
```

Packer will:

1. Launch temporary EC2
2. Install Nginx
3. Configure firewall
4. Create a new AMI
5. Terminate the temporary instance

Finally, you will see output similar to:

```
amazon-ebs: AMI created: ami-09c8d123abcd9e111
```
---

## 🎯 **After Building the AMI**

You can now use this AMI in:

* Terraform EC2 launch template
* Auto Scaling Groups
* Manual EC2 launch
* Jenkins deployment pipeline

Example Terraform:

```hcl
ami = "ami-09c8d123abcd9e111"
```
