# Total organizations and workspaces

This script counts the workspaces per organization as well as the total amount of orgnizations and workspaces that exist in a TFE installation. TFE has two endpoints (called "option 1" and "option 2"). The script illustrates the usage of both of them.

For more details see the API documentation:
* Option 1: https://www.terraform.io/docs/cloud/api/organizations.html
* Option 2: https://www.terraform.io/docs/cloud/api/admin/workspaces.html

The output looks as follows:

```
mkaesz@hashicorp ~/w/h/tfe_count_workspaces_per_org (master)> bash count_workspaces_per_org.sh
Option 1 iterates over all organizations and prints the workspaces per organization. It uses the 'api/v2/organizations' endpoint.

 msk1 has 3 workspaces(s)

Total organizations of the user: 1; total workspaces of user: 3


Option 2 lists the workspace for a specific organization. It uses the '/admin/workspaces' endpoint. The difference between option 1 and 2 is that option 2 needs a token from an admin user as it can list workspaces from all organizations. Option 1 can only list organizations the user is a member of.

 msk1 has 3 workspaces(s)
 msk2 has 2 workspaces(s)
 msk3 has 1 workspaces(s)

Total organizations: 3; total workspaces: 6

```
