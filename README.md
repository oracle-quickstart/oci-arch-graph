
## Oracle Cloud Graph on ADW

# [![Deploy to Oracle Cloud][magic_button]][magic_stack]


This architecture uses Oracle Autonomous Data Warehouse and creates a database user with the necessary permissions to perform graph operations. The architecture also includes Graph Studio Notebooks for easy graph data preparation and visualization. 

The repository contains the Terraform code to create a Resource Manager stack, that creates all the required resources and configures the created resources to add a graph user and the required `BANK_ACCOUNTS` and `BANK_TXNS` tables.

### Prerequisites 
-   Permission to  **`manage`**  the following types of resources in your Oracle Cloud Infrastructure tenancy:  **`autonomous-database-family`**, **`orm-family`**, **`virtual-network-family`**, **`network-security-groups`**, **`bastion`**, **`bastion-session`** and **`instance-family`**,.
-   Permission to  **`use`**  the following types of resources in your Oracle Cloud Infrastructure tenancy: **`tag-namespaces`**.
-   Quota to create one Autonomous Database on Shared Infrastructure instance with at least  **1 OCPU and 1 Tb storage**.

### Components
|Component| Description  |
|--|--|
|Autonomous Data Warehouse  | Platform for management and analysis of graph data |
| Identity Policy | Statements to grant the user access to the ADW and tags |

## Deployment Instructions
### Deploy Using Oracle Resource Manager
1. Click Deploy to Oracle Cloud. If you aren't already signed in, when prompted, enter the tenancy and user credentials.
2. Review and accept the terms and conditions
3. Select the region where you want to deploy the stack.
4. Follow the on-screen prompts and instructions to create the stack.
5. Wait for the job to be completed, and review the plan. To make any changes, return to the Stack Details page, click **Edit Stack**, and make the required changes. Then, run the **Plan** action again.
6. If no further changes are necessary, return to the Stack Details page, click  **Terraform Actions**, and select  **Apply**.

### Local Development
1. Perform pre-deployment setup described [here][oci-prereqs].
2. Clone the Module with the following commands to make a local copy fo the repo:

    ```bash
    git clone https://github.com/oracle-quickstart/oci-arch-graph.git
    cd oci-arch-graph/
    ls
    ```

3. To deploy directly with the terraform CLI, rename `terraform.tfvars.template` to `terraform.tfvars` and set all the variables. Run `terraform init` and then `terraform apply`.

    Note, the instructions below are to build a `.zip` file from your local copy for use in ORM. If you do not want to use ORM and instead deploy with the terraform CLI, then you need to rename `provider.tf.cli -> provider.tf`. This is because authentication works slightly differently in ORM vs the CLI. This file is ignored by the build process below. Make sure you have terraform v1.0+ cli installed and accessible from your terminal.

4. In order to `build` the zip file with the latest changes you made to this code, you can simply go to `build-orm` folder and use terraform to generate a new zip file:

    On the first run you are required to initialize the terraform modules used by the template with  `terraform init` command:

    ```bash
    terraform init
    ```

5. Once terraform is initialized, run `terraform apply` to generate ORM zip file:
   
    ```bash
    terraform apply
    data.archive_file.generate_zip: Refreshing state...
    Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
    ```

    This command will package the content of `terraform` folder into a zip and will store it in the `build-orm\dist` folder. You can check the content of the file by running `unzip -l dist/orm-graph-stack.zip`

6. [Login](https://cloud.oracle.com/resourcemanager/stacks/create) to Oracle Cloud Infrastructure to import the stack
    > `Home > Developer Services > Resource Manager > Stacks > Create Stack`
7. Upload the `orm-graph-stack.zip` and provide a name and description for the stack
8. Configure the Stack. The UI will present the variables to the user dynamically, based on their selections. 
9. Click Next and Review the configuration.
10. Click Create button to confirm and create your ORM Stack.
11. On Stack Details page, you can now run `Terraform` commands to manage your infrastructure. You typically start with a plan then run apply to create and make changes to the infrastructure. More details below:
        
    |      TERRAFORM ACTIONS     |           DESCRIPTION                                                 |
    |----------------------------|-----------------------------------------------------------------------|
    |Plan                        | `terraform plan` is used to create an execution plan. This command is a convenient way to check the execution plan prior to make any changes to the infrastructure resources.|
    |Apply                       | `terraform apply` is used to apply the changes required to reach the desired state of the configuration described by the template.|
    |Destroy                     | `terraform destroy` is used to destroy the Terraform-managed infrastructure.|


[oci-prereqs]: https://github.com/oracle/oci-quickstart-prerequisites
[magic_button]: https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg
[magic_stack]: https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oracle-quickstart/oci-arch-graph/releases/latest/download/orm-graph-stack.zip
