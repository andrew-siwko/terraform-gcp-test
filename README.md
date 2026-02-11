# Andrew's Multicloud Terraform Experiment
## Goal
The goal of this repo is to create a usable VM in the Google cloud.
Everything here was done using the GCP free trial.
After this step completed I used Ansible to configure and install Tomcat and run a sample application.  [More on that later...](https://github.com/andrew-siwko/ansible-multi-cloud-tomcat-hello)<br/>
It all starts with the [Cloud Console](https://console.cloud.google.com/).

## Multicloud
I tried to build the same basic structures in each of the cloud environments.  Each one starts with providers (and a backend), lays out the network and security, creates the VM and then registers the public IP in my DNS.  There is some variability which has been interesting to study.  The Terraform state file is stored on each provider.
* Step 1 - [AWS](https://github.com/andrew-siwko/terraform-aws-test)
* Step 2 - [Azure](https://github.com/andrew-siwko/terraform-azure-test)
* Step 3 - [GCP](https://github.com/andrew-siwko/terraform-gcp-test) (you are here)
* Step 4 - [Linode](https://github.com/andrew-siwko/terraform-linode-test)
* Step 5 - [IBM](https://github.com/andrew-siwko/terraform-ibm-test)
* Step 6 - [Oracle OCI](https://github.com/andrew-siwko/terraform-oracle-test) 

## Build Environment
I stood up my own Jenkins server and built a freestyle job to support the Terraform infrastructure builds.
* terraform init
* _some bash to import the domain (see below)_
* terraform plan
* terraform apply -auto-approve
* terraform output (This is piped to mail so I get an e-mail with the outputs.)

Yes, I know plan and apply should be separate and intentional.  In this case I found defects in plan which halted the job before apply.  That was useful.  I also commented out apply until plan was pretty close to working.<br/>
The Jenkins job contains environment variables with authentication information for the cloud environment and [Linode](https://www.linode.com/) (my registrar).<br/>
I did have a second job to import the domain zone but switched to a conditional in a script.  The code checks to see whether my zone record has been imported.  If not, the zone creation will fail.
```bash
if ! terraform state list | grep -q "linode_domain.dns_zone"; then
  echo "Resource not in state. Importing..."
  terraform import linode_domain.dns_zone 3417841
else
  echo "Domain already managed. Skipping import."
fi
```

## Observations
* GCP was my third provisioning project.
* I spent only 2 days getting this working.  The week in betwen was spent on other projects.
* Google required a "project" to contain the infrastructure.
* GCP's network provisioning was the easiest with the least detail required.  I tend to like more specificity.
  * GCP defined 4 ports in 2 lines of code. 
  * AWS: 4 lines of code per port.
  * Linode: 6 lines of code per port.
  * IBM: 7 lines of code per port.
  * Azure: 9 lines of code per port.
* The Google console felt different from the start.  I've written a few apps which use google services.  It felt like they fit their console into their existing developer framework.
* Project stats:
  * Start: 2026-01-21
  * Functional: 2026-01-28
  * Number of Jenkins builds to success: 34
  * Hurdles: 
    * None, after AWS and Azure, GCP was smooth.
