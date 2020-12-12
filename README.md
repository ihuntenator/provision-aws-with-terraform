# Provision AWS resources with Terraform

This is all from:

 * https://octopus.com/docs/runbooks/runbook-examples/terraform/provision-aws-with-terraform

And from here:

 * https://octopus.com/blog/dynamic-worker-army

Its not available in a gittery, so I'm putting it here. 


AWS CloudFormation is a great tool to use to provisions resources, however, it doesn't keep track of state. With runbooks, you can use Terraform to provision resources on AWS as well as keep them in the desired state.

The following example will use Terraform to dynamically create worker machines based on auto-scaling rules. Instead of defining the Terraform template directly in the step template, this example will make use of a package. The package will consist of the following files:

 * autoscaling.tf
 * autoscalingpolicy.tf
 * backend.tf
 * installTentacle.sh
 * provider.tf
 * securitygroup.tf
 * vars.tf
 * vpc.tf

The different AWS resources types have been separated into their respective files to make it easier to maintain.


## Create the runbook

 1 To create a runbook, navigate to Project ➜ Operations ➜ Runbooks ➜ Add Runbook.
 1 Give the runbook a name and click SAVE.
 1 Click DEFINE YOUR RUNBOOK PROCESS, then click ADD STEP.
 1 Add a Apply a Terraform template step.
 1 Fill in the template properties
   * Template Source: File inside a package
   * Package: Choose the package which contains the files above

With a single step in a runbook, you can create all the resources you need with Terraform.
