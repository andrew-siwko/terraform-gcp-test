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

## Build Environment
I stood up my own Jenkins server and built two freestyle jobs to support the Terraform infrastructure builds.  The main job calls 
* terraform init
* terraform plan
* terraform apply -auto-approve
* terraform output (This is piped to mail so I get an e-mail with the outputs.)

Yes, I know plan and apply should be separate and intentional.  In this case I found defects in plan which halted the job before apply.  That was useful.  I also commented out apply until plan was pretty close to working.<br/>
The first Jenkins job contains environment variables with authentication information for the cloud environment and [Linode](https://www.linode.com/) (my registrar).<br/>
The second Jenkins job imports my DNS zone.  I run it only once after the plan is complete.  After that Terraform happily manages records in my existing zone.


## Observations
* GCP was my third provisioning project.
* I spent only 2 days getting this working.  The week in betwen was spent on other projects.
* The Google console felt different from the start.  I've written a few apps which use google services.  It felt like they fit their console into their existing developer framework.
  * Start: 2026-01-21
  * Functional: 2026-01-28
  * Number of Jenkins builds to success: 34
  * Hurdles: 
    * None, after AWS and Azure, GCP was smooth.
