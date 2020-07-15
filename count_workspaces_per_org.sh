#!/bin/bash
# Exit if any of the intermediate steps fail
set -e

TFE_HOST='tfe.msk.pub'
TOKEN_USER='HSX19iWZXaieUg.atlasv1.0u3K6uMSgmHeVDzeHhak5THRSGDsMsPN3kK3t1dyzXcmXhsbiYohzvK9saXDKc5rc6A'
TOKEN_ADMIN='Xbr1MjNAFzOyAQ.atlasv1.GQtJQ62EmNwApNzhLRtxWiAzs5F98IUYGJII7gewdo2x92sL1zhfRLakoEV0ywmgIro'

echo "Option 1 iterates over all organizations and prints the workspaces per organization. It uses the 'api/v2/organizations' endpoint."
echo

orgs_user=$(curl -s \
         --header "Authorization: Bearer $TOKEN_USER" \
         --header "Content-Type: application/vnd.api+json" \
         --request GET \
         https://$TFE_HOST/api/v2/organizations | jq -r .data[].id)

for org in $orgs_user; do
  count=$(curl -s \
            --header "Authorization: Bearer $TOKEN_USER" \
            --header "Content-Type: application/vnd.api+json" \
            https://$TFE_HOST/api/v2/organizations/$org/workspaces | jq '.meta.pagination."total-count"')

  echo " $org has $count workspaces(s)" 
  total_organizations_user=$((total_organizations_user+1))
  total_workspaces_user=$((total_workspaces_user+$count))
done

echo
echo "Total organizations of the user: $total_organizations_user; total workspaces of user: $total_workspaces_user"
echo

echo
echo "Option 2 lists the workspace for a specific organization. It uses the '/admin/workspaces' endpoint. The difference between option 1 and 2 is that option 2 needs a token from an admin user as it can list workspaces from all organizations. Option 1 can only list organizations the user is a member of."
echo

orgs=$(curl -s \
         --header "Authorization: Bearer $TOKEN_ADMIN" \
         --header "Content-Type: application/vnd.api+json" \
         --request GET \
         https://$TFE_HOST/api/v2/organizations | jq -r .data[].id)


for org in $orgs; do
  count=$(curl -s \
            --header "Authorization: Bearer $TOKEN_ADMIN" \
            --header "Content-Type: application/vnd.api+json" \
            https://$TFE_HOST/api/v2/admin/workspaces?q=$org | jq '.meta.pagination."total-count"')

  echo " $org has $count workspaces(s)"
  total_organizations=$((total_organizations+1))
  total_workspaces=$((total_workspaces+$count))
done

echo
echo "Total organizations: $total_organizations; total workspaces: $total_workspaces"
echo
